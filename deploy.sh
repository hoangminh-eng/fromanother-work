#!/bin/bash
# Usage: ./deploy.sh "commit message"
MSG="${1:-update}"
git add work.html
git commit -m "$MSG"
git push
echo "⏳ Waiting for Vercel..."
sleep 20
URL=$(vercel ls 2>/dev/null | grep "Ready" | head -1 | awk '{print $3}')
if [ -n "$URL" ]; then
  vercel alias set "$URL" fromanother-work.vercel.app
  echo "✅ Live: https://fromanother-work.vercel.app"
else
  echo "⚠ Could not get deployment URL. Run manually:"
  echo "  vercel ls | head -3"
  echo "  vercel alias set <URL> fromanother-work.vercel.app"
fi
