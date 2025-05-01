# Create a new instance of the RandomNumberGenerator class
$generator = [System.Security.Cryptography.RandomNumberGenerator]::Create()

# Create a new byte array of 32 bytes (256 bits) to store the random key
$key = New-Object byte[] 32

# Use the generator to fill the byte array with random values
$generator.GetBytes($key)

# Convert the byte array to a Base64 string and set it as an environment variable 'JWT_SECRET'
$env:JWT_SECRET = [Convert]::ToBase64String($key)

# Output the Base64-encoded JWT secret to confirm the environment variable is set correctly
echo $env:JWT_SECRET
