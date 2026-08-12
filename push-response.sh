#!/usr/bin/env bash
set -euo pipefail

token="${1:?Usage: push-response.sh <session-token>}"
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
response_file="${token}-response.md"
diff_file="${token}-diff.patch"

cd "$repo"

for file in "$response_file" "$diff_file"; do
  [[ -f "$file" ]] || {
    echo "Missing: $repo/$file" >&2
    exit 1
  }
done

git add -- "$response_file" "$diff_file"

if ! git diff --cached --quiet -- "$response_file" "$diff_file"; then
  git commit -m "Add response $token"
fi

git pull --rebase origin main
git push origin main
