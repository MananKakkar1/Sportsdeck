# SportsDeck Vercel Deployment Guide

This guide will help you deploy SportsDeck to Vercel.

## Prerequisites

1. **Vercel Account**: Sign up at [vercel.com](https://vercel.com)
2. **GitHub Account**: Ensure your code is pushed to GitHub
3. **Vercel CLI** (optional): `npm install -g vercel`
4. **External Services**:
   - PostgreSQL database (Vercel Postgres, Supabase, or other provider)
   - Redis instance (Vercel Redis, Upstash, or other provider)
   - Cloudinary account (for image uploads)
   - Hugging Face API token (for sentiment analysis)

## Step 1: Prepare External Services

### PostgreSQL Database
You'll need a PostgreSQL database since Vercel doesn't support running persistent databases. Options:

**Option A: Vercel Postgres** (Recommended for Vercel integration)
```bash
vercel env add DATABASE_URL
# Follow Vercel's guide at: https://vercel.com/docs/storage/vercel-postgres
```

**Option B: Supabase**
1. Create a project at [supabase.com](https://supabase.com)
2. Get the connection string from Settings → Database → Connection String
3. Copy the PostgreSQL connection string

**Option C: Other providers**
- Railway: https://railway.app
- Render: https://render.com
- AWS RDS: https://aws.amazon.com/rds

### Redis Cache (Optional but Recommended)
**Option A: Vercel Redis**
```bash
vercel env add REDIS_URL
# Follow Vercel's guide at: https://vercel.com/docs/storage/vercel-redis
```

**Option B: Upstash**
1. Create account at [upstash.com](https://upstash.com)
2. Create a new database
3. Copy the Redis URL

### Generate Required Secrets
Generate random secrets for authentication:
```bash
# Generate NEXTAUTH_SECRET
openssl rand -base64 32

# Generate ACCESS_TOKEN_SECRET
openssl rand -base64 32

# Generate REFRESH_TOKEN_SECRET
openssl rand -base64 32

# Generate VERCEL_CRON_SECRET (for secure cron jobs)
openssl rand -base64 32
```

## Step 2: Connect Your Repository to Vercel

### Option A: Using Vercel Dashboard (Easiest)
1. Go to [vercel.com/dashboard](https://vercel.com/dashboard)
2. Click "Add New..." → "Project"
3. Select your GitHub repository
4. Click "Import"

### Option B: Using Vercel CLI
```bash
cd sportsdeck
vercel link
# Follow the prompts to connect your project
```

## Step 3: Configure Environment Variables

### Via Vercel Dashboard
1. Go to your project settings
2. Navigate to "Environment Variables"
3. Add all required variables:

**Essential Variables:**
```
DATABASE_URL=postgresql://[user]:[password]@[host]:[port]/[dbname]
NEXTAUTH_URL=https://your-project.vercel.app
NEXTAUTH_SECRET=[generated secret]
ACCESS_TOKEN_SECRET=[generated secret]
REFRESH_TOKEN_SECRET=[generated secret]
VERCEL_CRON_SECRET=[generated secret]
```

**Optional Variables:**
```
REDIS_URL=redis://[connection-string]
HF_TOKEN=[your-hugging-face-token]
CLOUDINARY_CLOUD_NAME=[your-cloud-name]
CLOUDINARY_API_KEY=[your-api-key]
CLOUDINARY_API_SECRET=[your-api-secret]
NEXT_PUBLIC_API_URL=https://your-project.vercel.app
```

### Via Vercel CLI
```bash
vercel env add
# Follow prompts to add environment variables
```

## Step 4: Deploy

### Option A: Automatic Deployment (Recommended)
Vercel will automatically deploy when you push to your main branch:
```bash
git add .
git commit -m "Setup for Vercel deployment"
git push origin main
```

### Option B: Manual Deployment
```bash
cd sportsdeck
vercel --prod
```

## Step 5: Run Database Migrations

After deployment, you need to run Prisma migrations on the deployed database:

### Option A: Using Vercel CLI
```bash
vercel env pull .env.local
npm run db:migrate
```

### Option B: Manual Migration
```bash
# Set DATABASE_URL to your production database
export DATABASE_URL="your-production-database-url"
npx prisma migrate deploy
```

## Step 6: Verify Deployment

1. Check your deployment at `https://your-project.vercel.app`
2. Verify cron jobs in Vercel dashboard:
   - Project Settings → Crons
   - You should see `/api/cron/matches` and `/api/cron/sentiment`
3. Test API endpoints:
   ```bash
   curl https://your-project.vercel.app/api/health
   ```

## Troubleshooting

### Build Fails with Prisma Error
```bash
# Make sure Prisma generate runs post-install
npm run postinstall
```

### Database Migration Fails
```bash
# Pull environment variables locally
vercel env pull .env.local

# Run migrations manually
npx prisma migrate deploy
```

### Cron Jobs Not Running
1. Verify `VERCEL_CRON_SECRET` is set
2. Check cron job logs in Vercel dashboard
3. Ensure `/api/cron/matches` and `/api/cron/sentiment` routes exist

### Images Not Loading
1. Add image domain to `next.config.ts`
2. Redeploy after making changes

## Monitoring & Logs

View deployment logs:
```bash
vercel logs
```

View live logs:
```bash
vercel logs --follow
```

## Scaling & Performance

For production use:
1. **Enable Automatic Deployments**: Push to main branch
2. **Monitor Performance**: Use Vercel Analytics
3. **Scale Database**: Upgrade your PostgreSQL plan if needed
4. **Cache Management**: Consider increasing Redis memory if needed

## Security Best Practices

1. ✅ Never commit `.env.local` to git
2. ✅ Use strong, random secrets (use `openssl rand -base64 32`)
3. ✅ Set `VERCEL_CRON_SECRET` for cron job protection
4. ✅ Rotate secrets periodically
5. ✅ Enable branch protection rules on GitHub

## Useful Commands

```bash
# View project settings
vercel projects list

# Redeploy last production deployment
vercel --prod --force

# Preview deployment
vercel preview

# Check environment variables
vercel env ls

# Pull environment variables locally
vercel env pull .env.local

# View deployment status
vercel status
```

## Support

- Vercel Documentation: https://vercel.com/docs
- Next.js Deployment: https://nextjs.org/learn/deployment
- Prisma Deployment: https://www.prisma.io/docs/guides/deployment

For issues specific to this project, open an issue on GitHub.
