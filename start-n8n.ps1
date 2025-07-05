# Check if Docker is installed
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "Docker not found. Please install Docker Desktop."
    Start-Process "https://www.docker.com/products/docker-desktop"
    exit
}

# Pull the latest n8n Docker image
docker pull n8nio/n8n

# Set up persistent volume path
$volumePath = "C:\n8n-order-project\data"

if (-not (Test-Path $volumePath)) {
    New-Item -ItemType Directory -Path $volumePath | Out-Null
    Write-Host "Created local data directory at $volumePath"
}

# Stop and remove existing container if running
if (docker ps -a --format "{{.Names}}" | Select-String "n8n-order-email") {
    docker stop n8n-order-email | Out-Null
    docker rm n8n-order-email | Out-Null
}

# Run n8n Docker container
docker run -d --name n8n-order-email `
    -p 5678:5678 `
    -v "${volumePath}:/home/node/.n8n"
-e N8N_BASIC_AUTH_ACTIVE=true `
    -e N8N_BASIC_AUTH_USER=admin `
    -e N8N_BASIC_AUTH_PASSWORD=admin123 `
    n8nio/n8n

Start-Sleep -Seconds 5

Write-Host "n8n is running at http://localhost:5678"
Write-Host "Username: admin"
Write-Host "Password: admin123"

# Open n8n in a browser
Start-Process "http://localhost:5678"