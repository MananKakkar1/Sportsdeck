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
    console.log("Starting match fetch cron job...");
    const { stdout, stderr } = await execAsync("node scripts/cron/fetch-matches.cjs", {
      timeout: 60000, // 60 second timeout
    });

    console.log("Match fetch output:", stdout);
    if (stderr) console.error("Match fetch errors:", stderr);

    return NextResponse.json(
      { 
        success: true, 
        message: "Match fetch completed",
        timestamp: new Date().toISOString()
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error in match fetch cron:", error);
    return NextResponse.json(
      { 
        error: "Failed to fetch matches",
        details: error instanceof Error ? error.message : String(error)
      },
      { status: 500 }
    );
  }
}
