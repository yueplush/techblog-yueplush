#!/usr/bin/env fish

# autopush.sh — fish用
# 自動 add → commit → pull --rebase → push

set repo "/home/yueplush/techblog-yueplush"
set msg (test (count $argv) -gt 0; and echo "$argv"; or date "+auto: %Y-%m-%d %H:%M:%S")

# move to repo
if test (pwd) != $repo
    cd $repo
end

# ✅ git repo check (fish 正式版)
git rev-parse --is-inside-work-tree > /dev/null 2>&1
if test $status -ne 0
    echo "❌ not a git repo: $repo"
    exit 1
end

echo "📦 staging changes..."
git add -A

# no changes?
git diff --cached --quiet
if test $status -eq 0
    echo "✅ no changes to commit"
    exit 0
end

echo "📝 commit: $msg"
git commit -m "$msg"

echo "🔄 pull --rebase --autostash"
git pull --rebase --autostash

echo "⬆️ pushing..."
git push

echo "✅ done — Cloudflare Pages deploying..."
