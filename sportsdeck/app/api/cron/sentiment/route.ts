import { NextRequest, NextResponse } from "next/server";
import { exec } from "child_process";
import { promisify } from "util";

const execAsync = promisify(exec);

// Verify the request is from Vercel's cron service
function verifyCronSecret(request: NextRequest): boolean {
  const authHeader = request.headers.get("authorization");
  const cronSecret = process.env.VERCEL_CRON_SECRET;

  if (!cronSecret) {
    console.warn("VERCEL_CRON_SECRET not set");
    return process.env.NODE_ENV === "development";
  }

  return authHeader === `Bearer ${cronSecret}`;
}

export async function GET(request: NextRequest) {
  if (!verifyCronSecret(request)) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    console.log("Starting sentiment analysis cron job...");
    const { stdout, stderr } = await execAsync("node scripts/cron/analyze-sentiments.cjs", {
      timeout: 120000, // 120 second timeout
    });

    console.log("Sentiment analysis output:", stdout);
    if (stderr) console.error("Sentiment analysis errors:", stderr);

    return NextResponse.json(
      { 
        success: true, 
        message: "Sentiment analysis completed",
        timestamp: new Date().toISOString()
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error in sentiment analysis cron:", error);
    return NextResponse.json(
      { 
        error: "Failed to analyze sentiments",
        details: error instanceof Error ? error.message : String(error)
      },
      { status: 500 }
    );
  }
}
