#!/bin/bash
# Vercel Deployment Setup Script
# This script helps set up SportsDeck on Vercel

set -e

echo "================================"
echo "SportsDeck Vercel Setup"
echo "================================"
echo ""

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI not found. Installing..."
    npm install -g vercel
fi

echo "✅ Vercel CLI is available"
echo ""

# Step 1: Initialize Vercel project
echo "Step 1: Initializing Vercel project..."
echo "If this is your first time, you'll be prompted to login."
read -p "Press enter to continue with 'vercel link'..."
vercel link

echo ""
echo "Step 2: Setting up environment variables..."
echo "You need to set these environment variables in Vercel:"
echo ""
echo "Required:"
echo "  - DATABASE_URL: PostgreSQL connection string"
echo "  - NEXTAUTH_URL: https://your-domain.vercel.app"
echo "  - NEXTAUTH_SECRET: $(openssl rand -base64 32)"
echo "  - ACCESS_TOKEN_SECRET: $(openssl rand -base64 32)"
echo "  - REFRESH_TOKEN_SECRET: $(openssl rand -base64 32)"
echo "  - VERCEL_CRON_SECRET: $(openssl rand -base64 32)"
echo ""
echo "Optional:"
echo "  - REDIS_URL: Redis connection string"
echo "  - HF_TOKEN: Hugging Face API token"
echo "  - CLOUDINARY_* variables"
echo ""
read -p "Open Vercel dashboard and set environment variables. Press enter when done..."

echo ""
echo "Step 3: Deploy to Vercel..."
read -p "Press enter to deploy..."
vercel --prod

echo ""
echo "================================"
echo "✅ Deployment Complete!"
echo "================================"
echo ""
echo "Next steps:"
echo "1. Check your deployment at: vercel.com/dashboard"
echo "2. Run database migrations:"
echo "   vercel env pull .env.local"
echo "   npm run db:migrate"
echo "3. Your app should be live at your Vercel URL"
echo ""
