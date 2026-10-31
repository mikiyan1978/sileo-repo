#!/bin/sh
# Installs YTDownloader's self-built runtime bundle: a Python 3.13
# interpreter (for yt-dlp) + Node.js 22 and bgutil-pot-provider (for the
# PO-token server that unlocks full-quality downloads).
#
# This bundle is required, not optional-but-nice: yt-dlp's current release
# hard-requires Python 3.11+ (confirmed on-device -- running the latest
# yt-dlp under this device's apt-available Python 3.9 fails immediately
# with "Only Python versions 3.11 and above are supported by yt-dlp"), and
# no jailbreak package repo (Procursus et al.) currently ships a Python
# newer than 3.9. Without this bundle, YTDownloader falls back to an
# apt/pip-installed yt-dlp if one exists, capped at 360p.
#
# Usage (run as root on the target device, e.g. over SSH):
#   sh install_runtime_bundle.sh                      # downloads the bundle itself
#   sh install_runtime_bundle.sh /path/to/bundle.tar.gz  # uses an already-downloaded copy
#
# Detects rootful vs. rootless jailbreak layout automatically (checks for
# /var/jb) and installs to the matching location.

set -e

BUNDLE_URL="https://github.com/mikiyan1978/sileo-repo/releases/download/ytdownloader-runtime-v1/ytd_runtime_bundle.tar.gz"
ARCHIVE="$1"

if [ "$(id -u)" != "0" ]; then
    echo "Must be run as root." >&2
    exit 1
fi

if [ -d /var/jb ]; then
    BASE=/var/jb/usr/local
    echo "Detected rootless jailbreak layout -- installing under $BASE"
else
    BASE=/usr/local
    echo "Detected rootful jailbreak layout -- installing under $BASE"
fi

mkdir -p "$BASE/lib" "$BASE/bin"

CLEANUP_ARCHIVE=0
if [ -z "$ARCHIVE" ]; then
    echo "Downloading runtime bundle (~120MB compressed)..."
    ARCHIVE=/tmp/ytd_runtime_bundle.tar.gz
    curl -L --fail -o "$ARCHIVE" "$BUNDLE_URL"
    CLEANUP_ARCHIVE=1
fi

echo "Extracting to $BASE ..."
tar xzf "$ARCHIVE" -C "$BASE"

chown -R mobile:mobile "$BASE/lib/python-ios" "$BASE/lib/node-ios" "$BASE/lib/bgutil-pot-provider" 2>/dev/null || true
chmod +x "$BASE/bin/node22" 2>/dev/null || true
find "$BASE/lib/python-ios/bin" -type f -exec chmod +x {} \; 2>/dev/null || true

if [ "$CLEANUP_ARCHIVE" = "1" ]; then
    rm -f "$ARCHIVE"
fi

echo "Done. (Re)launch YTDownloader -- it detects this bundle automatically, no respring needed."
