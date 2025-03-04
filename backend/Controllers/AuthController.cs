using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Google.Apis.Auth;

[Route("api/auth")]
[ApiController]
public class AuthController : ControllerBase
{
    private readonly AuthService _authService;

    public AuthController(AuthService authService)
    {
        _authService = authService;
    }

    [HttpPost("google")]
    public async Task<IActionResult> GoogleLogin([FromBody] GoogleLoginRequest request)
    {
        if (string.IsNullOrEmpty(request.IdToken))
            return BadRequest("Invalid token.");

        // Verify Google token with Firebase (or Google's endpoint)
        var payload = await GoogleJsonWebSignature.ValidateAsync(request.IdToken);
        if (payload == null)
            return Unauthorized();

        string jwtToken = await _authService.AuthenticateGoogleUser(payload.Subject, payload.Email, payload.Name);
        return Ok(new { token = jwtToken });
    }
}

public class GoogleLoginRequest
{
    public string IdToken { get; set; }
}