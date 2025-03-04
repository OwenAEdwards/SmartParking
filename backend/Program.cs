using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using MongoDB.Bson;
using MongoDB.Driver;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// Configure MongoDbSettings and MongoDbContext
builder.Services.Configure<MongoDbSettingsModel>(builder.Configuration.GetSection("MongoDbSettings"));
builder.Services.AddSingleton<MongoDbContext>();

// Register AuthService and other dependencies
builder.Services.AddScoped<AuthService>();

// Add Authentication and Authorization
builder.Services.AddAuthentication()
    .AddJwtBearer(options =>
    {
        // Set up JWT Bearer token options, including validation, etc.
        options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"], // Set in appsettings.json
            ValidAudience = builder.Configuration["Jwt:Audience"], // Set in appsettings.json
            IssuerSigningKey = new Microsoft.IdentityModel.Tokens.SymmetricSecurityKey(
                System.Text.Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Secret"])) // Secret Key from appsettings.json
        };
    });

builder.Services.AddAuthorization();

// Add MVC Controllers
builder.Services.AddControllers();

// Build the app
var app = builder.Build();

// Test MongoDB connection and log the result
var mongoConnectionString = builder.Configuration.GetValue<string>("MONGO_DB_CONNECTION_STRING");
var client = new MongoClient(mongoConnectionString);
var database = client.GetDatabase("SmartParkingDb");

int maxRetries = 10;
int retryCount = 0;
bool connected = false;

while (retryCount < maxRetries && !connected)
{
    try
    {
        // Run a simple command to test the connection
        database.RunCommandAsync((Command<BsonDocument>)"{ping:1}").Wait();
        app.Logger.LogInformation("Successfully connected to MongoDB.");
        connected = true;
    }
    catch (Exception ex)
    {
        retryCount++;
        app.Logger.LogWarning($"Attempt {retryCount}/{maxRetries} failed to connect to MongoDB: {ex.Message}");
        if (retryCount >= maxRetries)
        {
            app.Logger.LogError("Max retries reached. Failed to connect to MongoDB.");
        }
        else
        {
            // Wait before retrying
            System.Threading.Thread.Sleep(5000); // 5-second delay
        }
    }
}

// Configure the HTTP request pipeline
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseRouting();

// Apply JWT Middleware for authentication
app.UseMiddleware<JwtMiddleware>();

// Use Authentication and Authorization
app.UseAuthentication();
app.UseAuthorization();

// Define the routes for static assets, controllers, etc.
app.MapStaticAssets();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}")
    .WithStaticAssets();

app.Run();
