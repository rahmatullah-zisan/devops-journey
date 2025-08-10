#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="${1:-$HOME/projects/devops-journey}"
DEST_DIR="${2:-$HOME/backups}"
KEEP="${3:-7}"

timestamp=$(date +'%Y-%m-%d_%H%M%S')
mkdir -p "$DEST_DIR"

basename_src=$(basename "$SRC_DIR")
archive="$DEST_DIR/backup_${basename_src}_${timestamp}.tar.gz"

# create archive
tar -czf "$archive" -C "$(dirname "$SRC_DIR")" "$basename_src"

# rotate: keep latest $KEEP files
cd "$DEST_DIR"
# safe removal: if no extra files, nothing happens
ls -1t | tail -n +$((KEEP+1)) | xargs -r rm -f --

echo "Backup created: $archive"
echo "Kept latest $KEEP backups in $DEST_DIR"
