# SportsDeck Vercel Deployment Setup - Windows
# Run this script in PowerShell to set up deployment

Write-Host "================================" -ForegroundColor Cyan
Write-Host "SportsDeck Vercel Setup Wizard" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Check if Vercel CLI is installed
try {
    $vercelVersion = vercel --version
    Write-Host "✅ Vercel CLI found: $vercelVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Vercel CLI not found. Installing..." -ForegroundColor Yellow
    npm install -g vercel
    Write-Host "✅ Vercel CLI installed" -ForegroundColor Green
}

Write-Host ""
Write-Host "Generating required secrets..." -ForegroundColor Cyan
Write-Host ""

function Generate-RandomSecret {
    return [System.Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(32))
}

Write-Host "NEXTAUTH_SECRET:" -ForegroundColor Yellow
Generate-RandomSecret
Write-Host ""

Write-Host "ACCESS_TOKEN_SECRET:" -ForegroundColor Yellow
Generate-RandomSecret
Write-Host ""

Write-Host "REFRESH_TOKEN_SECRET:" -ForegroundColor Yellow
Generate-RandomSecret
Write-Host ""

Write-Host "VERCEL_CRON_SECRET (for cron job authentication):" -ForegroundColor Yellow
Generate-RandomSecret
Write-Host ""

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Copy the secrets above"
Write-Host "2. Go to Vercel Dashboard (https://vercel.com/dashboard)"
Write-Host "3. Select your project"
Write-Host "4. Go to Settings → Environment Variables"
Write-Host "5. Add each secret"
Write-Host ""
Write-Host "6. Also add these variables:" -ForegroundColor Yellow
Write-Host "   - DATABASE_URL: Your PostgreSQL connection string"
Write-Host "   - NEXTAUTH_URL: https://your-project.vercel.app"
Write-Host "   - REDIS_URL: Your Redis connection string (optional)"
Write-Host "   - HF_TOKEN: Your Hugging Face token (optional)"
Write-Host "   - CLOUDINARY_* variables (optional)"
Write-Host ""
Write-Host "7. Push your code to deploy:" -ForegroundColor Yellow
Write-Host "   git push origin main"
Write-Host ""
Write-Host "For detailed instructions, see: VERCEL_DEPLOYMENT.md"
Write-Host ""

$response = Read-Host "Do you want to link this project to Vercel now? (y/n)"
if ($response -eq "y") {
    vercel link
    Write-Host "✅ Project linked to Vercel" -ForegroundColor Green
}

Write-Host ""
Write-Host "Setup wizard complete!" -ForegroundColor Green
