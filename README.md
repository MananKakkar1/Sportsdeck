# SportsDeck

A modern, full-stack web application for sports enthusiasts to discuss matches, teams, and sports-related content through forums, real-time updates, interactive features, and AI-powered sentiment analysis.

## 📋 Features

- **User Authentication**: Secure login and signup with NextAuth.js and JWT tokens
- **Community Forums**: Create and participate in sports discussion threads
- **Match Information**: Live match details, standings, and real-time updates
- **Team Profiles**: Comprehensive team information with custom themes
- **User Profiles**: Personalized profiles with following/followers functionality
- **Interactive Content**: Create polls, posts, and engage with the community
- **Admin Dashboard**: Moderation tools for managing reports and appeals
- **AI Sentiment Analysis**: Track community sentiment on match threads using Hugging Face
- **Responsive Design**: Mobile-friendly interface built with Tailwind CSS
- **Real-time Data**: Automated cron jobs for match syncing and sentiment computation

## 🛠️ Tech Stack

- **Frontend**: Next.js 16, React 19, Tailwind CSS
- **Backend**: Next.js API Routes
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: NextAuth.js with JWT
- **Caching**: Redis
- **AI/ML**: Hugging Face Inference API for sentiment analysis
- **Image Storage**: Cloudinary
- **Containerization**: Docker, Docker Compose
- **Testing**: Jest
- **Code Quality**: ESLint

## 📦 Prerequisites

- Node.js 18 or higher
- Docker and Docker Compose
- PostgreSQL (can use Docker container)
- Redis (optional, can use Docker container)

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/MananKakkar1/Sportsdeck.git
cd Sportsdeck/sportsdeck
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Setup Environment Variables
Create a `.env.local` file in the `sportsdeck` directory:
```bash
cp .env.example .env.local
```

Configure the following variables:
```env
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/sportsdeck

# Authentication
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=your-secret-here
ACCESS_TOKEN_SECRET=your-access-token-secret
REFRESH_TOKEN_SECRET=your-refresh-token-secret

# Redis
REDIS_URL=redis://localhost:6379

# AI/ML
HF_TOKEN=your-hugging-face-token

# Image Uploads
CLOUDINARY_CLOUD_NAME=your-cloud-name
CLOUDINARY_API_KEY=your-api-key
CLOUDINARY_API_SECRET=your-api-secret

# Optional: NBA API
NBA_API_KEY=your-nba-api-key
```

### 4. Setup Database
```bash
npx prisma migrate dev
npx prisma generate
```

### 5. (Optional) Import Sample Data
```bash
./import-data.sh
```

## 📖 Running the Application

### Development Mode
```bash
npm run dev
```
Open [http://localhost:3000](http://localhost:3000)

### Production Build
```bash
npm run build
npm start
```

### Using Docker
```bash
docker-compose up --build
```
Access the app at [http://localhost:8087](http://localhost:8087)

## 🧪 Testing

Run the test suite:
```bash
npm test
```

Run tests in watch mode:
```bash
npm run test:watch
```

## 📁 Project Structure

```
sportsdeck/
├── app/                    # Next.js app directory
│   ├── api/               # API routes
│   ├── (main)/            # Main application pages
│   └── admin/             # Admin dashboard
├── components/            # Reusable React components
├── lib/                   # Utility functions and configurations
├── prisma/                # Database schema and migrations
├── public/                # Static assets
├── tests/                 # Test files
├── scripts/               # Utility scripts and cron jobs
└── docker/                # Docker configuration files
```

## 🔧 Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm test` - Run test suite
- `npm run lint` - Run ESLint
- `./start.sh` - Start the application with services
- `./stop.sh` - Stop all running services

## 🗄️ Database

This project uses PostgreSQL with Prisma as the ORM. Key entities include:
- Users and authentication
- Posts, threads, and forums
- Matches and standings
- Polls and voting
- Reports and appeals
- Follow relationships

To view and manage your database:
```bash
npx prisma studio
```

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:
1. Create a new branch for your feature
2. Make your changes
3. Run tests to ensure they pass
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 📧 Contact

For questions or support, please open an issue on GitHub.
