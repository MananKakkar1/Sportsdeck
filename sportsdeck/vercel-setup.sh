#!/bin/bash
# Quick setup for Vercel deployment
# This script generates required secrets and shows next steps

echo "======================================="
echo "SportsDeck Vercel Setup Wizard"
echo "======================================="
echo ""

echo "Generating required secrets..."
echo ""

echo "NEXTAUTH_SECRET:"
openssl rand -base64 32
echo ""

echo "ACCESS_TOKEN_SECRET:"
openssl rand -base64 32
echo ""

echo "REFRESH_TOKEN_SECRET:"
openssl rand -base64 32
echo ""

echo "VERCEL_CRON_SECRET (for cron job authentication):"
openssl rand -base64 32
echo ""

echo "======================================="
echo "Next Steps:"
echo "======================================="
echo ""
echo "1. Copy the secrets above"
echo "2. Go to Vercel Dashboard (https://vercel.com/dashboard)"
echo "3. Select your project"
echo "4. Go to Settings → Environment Variables"
echo "5. Add each secret"
echo ""
echo "6. Also add these variables:"
echo "   - DATABASE_URL: Your PostgreSQL connection string"
echo "   - NEXTAUTH_URL: https://your-project.vercel.app"
echo "   - REDIS_URL: Your Redis connection string (optional)"
echo "   - HF_TOKEN: Your Hugging Face token (optional)"
echo "   - CLOUDINARY_* variables (optional)"
echo ""
echo "7. Push your code to deploy:"
echo "   git push origin main"
echo ""
echo "For detailed instructions, see: VERCEL_DEPLOYMENT.md"
echo ""
