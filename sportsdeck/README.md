# SportsDeck

SportsDeck is a modern web application built with Next.js for sports enthusiasts. It provides a platform for discussing matches, teams, and sports-related content through forums, real-time updates, user profiles, and interactive features like polls and sentiment analysis.

## Features

- **User Authentication**: Secure login and signup with NextAuth.js
- **Forums and Threads**: Community discussions on sports topics
- **Match Details**: Live match information, standings, and updates
- **Team Profiles**: Detailed team information and themes
- **User Profiles**: Personalized profiles with following/followers
- **Polls and Posts**: Interactive content creation
- **Admin Panel**: Moderation tools for reports and appeals
- **Sentiment Analysis**: AI-powered sentiment tracking on match threads
- **Real-time Updates**: Cron jobs for match syncing and sentiment computation
- **Responsive Design**: Mobile-friendly UI with Tailwind CSS

## Tech Stack

- **Frontend**: Next.js 16, React 19, Tailwind CSS
- **Backend**: Next.js API Routes
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: NextAuth.js with JWT
- **Caching**: Redis
- **AI/ML**: Hugging Face Inference API for sentiment analysis
- **Deployment**: Docker, Docker Compose
- **Testing**: Jest
- **Linting**: ESLint

## Prerequisites

- Node.js 18 or higher
- Docker and Docker Compose
- PostgreSQL (optional, can use Docker container)

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd sportsdeck
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

## Setup

1. Create environment file:
   ```bash
   cp .env.example .env.local
   ```

2. Configure environment variables in `.env.local`:
   - `DATABASE_URL`: PostgreSQL connection string
   - `NEXTAUTH_URL`: Your app's URL
   - `NEXTAUTH_SECRET`: Random secret for NextAuth
   - `ACCESS_TOKEN_SECRET`: JWT access token secret
   - `REFRESH_TOKEN_SECRET`: JWT refresh token secret
   - `REDIS_URL`: Redis connection string
   - `HF_TOKEN`: Hugging Face API token for sentiment analysis
   - `CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, `CLOUDINARY_API_SECRET`: For image uploads
   - Other optional variables as needed

3. Set up the database:
   ```bash
   npx prisma migrate dev
   npx prisma generate
   ```

4. (Optional) Import initial data:
   ```bash
   ./import-data.sh
   ```

## Running the Application

### Development
```bash
npm run dev
```
Open [http://localhost:3000](http://localhost:3000) to view the app.

### Production Build
```bash
npm run build
npm start
```

### With Docker
```bash
docker-compose up --build
```
The app will be available at [http://localhost:8087](http://localhost:8087).

## Testing

Run the test suite:
```bash
npm test
```

Run tests in watch mode:
```bash
npm run test:watch
```

## API Documentation

- OpenAPI specification: `../openapi.yaml`
- Postman collection: `../postman_collection.json`

## Cron Jobs (Docker Deployment)

This project includes two cron-friendly scripts:

- `npm run cron:matches`
  - Calls `/api/matches` for a rolling 14-day window (`today` to `today + 13 days`).
  - Reuses the existing API logic for match ingestion, DB upserts, and thread synchronization.
- `npm run cron:sentiment`
  - Computes sentiment for active match threads and upserts one sentiment record per match.

### Required environment variables

- `DATABASE_URL` (required for sentiment job)
- `HF_TOKEN` (required for sentiment job unless `MOCK_EXTERNAL_APIS=true`)
- `CRON_BASE_URL` or `APP_BASE_URL` (required for match job when it calls your app endpoint)
- `CRON_SECRET` (optional, sent as `x-cron-secret` header)

### Optional environment variables

- `SENTIMENT_CRON_COOLDOWN_MINUTES` (default: `30`)
- `SENTIMENT_CRON_MATCH_LIMIT` (default: `50`)

### Example crontab entries (host-level cron)

Assuming your running app container is named `sportsdeck-app`:

```cron
# Every hour, fetch/sync NBA matches
5 * * * * docker exec sportsdeck-app sh -lc 'cd /app && npm run cron:matches'

# Every 30 minutes, refresh sentiment for active match threads
*/30 * * * * docker exec sportsdeck-app sh -lc 'cd /app && npm run cron:sentiment'
```

### Manual verification

Run once to verify behavior before adding schedules:

```bash
npm run cron:matches
npm run cron:sentiment
```

## Deployment

### Docker Deployment
Use the provided `docker-compose.yaml` for production deployment with PostgreSQL and Redis.

### Vercel Deployment
1. Connect your repository to Vercel
2. Set environment variables in Vercel dashboard
3. Deploy

Ensure database and Redis are accessible (consider using hosted services like Vercel Postgres or Railway).

## Scripts

- `npm run dev`: Start development server
- `npm run build`: Build for production
- `npm start`: Start production server
- `npm run lint`: Run ESLint
- `npm test`: Run Jest tests
- `npm run db:migrate`: Run Prisma migrations
- `npm run db:generate`: Generate Prisma client
- `npm run db:reset`: Reset database
- `npm run cron:matches`: Fetch and sync matches
- `npm run cron:sentiment`: Analyze sentiment
- `npm run cron:run`: Run both cron jobs

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Submit a pull request

Please ensure tests pass and code is linted before submitting.

## License

This project is private and proprietary.
