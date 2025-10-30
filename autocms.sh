#!/usr/bin/env fish

echo "=== Starting Decap CMS local server ==="
# kill existing decap-server to avoid duplicates
pkill -f "decap-server" >/dev/null 2>&1

# start decap in background
nohup npx decap-server >/tmp/decap.log 2>&1 &
echo "Decap CMS running at http://localhost:8081"

echo "=== Starting Hugo server ==="
hugo server -D --disableFastRender
