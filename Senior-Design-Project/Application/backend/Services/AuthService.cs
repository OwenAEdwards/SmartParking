using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using MongoDB.Driver;

public class AuthService
{
    private readonly MongoDbContext _context;
    private readonly IConfiguration _config;

    public AuthService(MongoDbContext context, IConfiguration config)
    {
        _context = context;
        _config = config;
    }

    public async Task<string> AuthenticateGoogleUser(string googleId, string email, string displayName)
    {
        var user = await _context.Users.Find(u => u.GoogleId == googleId).FirstOrDefaultAsync();
        if (user == null)
        {
            user = new UserModel { GoogleId = googleId, Email = email, DisplayName = displayName };
            await _context.Users.InsertOneAsync(user);
        }

        return GenerateJwtToken(user);
    }

    private string GenerateJwtToken(UserModel user)
    {
        // Get the secret key from configuration and ensure it is at least 256 bits (32 bytes)
        var secretKey = _config["Jwt:Secret"];
        var key = Encoding.UTF8.GetBytes(secretKey);

        // If the key is shorter than 32 bytes, pad it
        if (key.Length < 32)
        {
            var paddedKey = new byte[32];
            Array.Copy(key, paddedKey, key.Length);
            key = paddedKey;
        }
        
        var tokenHandler = new JwtSecurityTokenHandler();
        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(new Claim[]
            {
                new Claim(ClaimTypes.NameIdentifier, user.Id),
                new Claim(ClaimTypes.Email, user.Email)
            }),
            Expires = DateTime.UtcNow.AddDays(7),
            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
        };
        var token = tokenHandler.CreateToken(tokenDescriptor);
        return tokenHandler.WriteToken(token);
    }
}