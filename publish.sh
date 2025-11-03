#!/bin/bash
set -e

echo "🦀 Publishing deckyfx-dioxus-ipc-bridge-macros to crates.io..."
echo ""

# Check if logged in
echo "🔐 Checking cargo login..."
if ! cargo login --help &> /dev/null; then
    echo "❌ Please run 'cargo login' first with your crates.io API token"
    exit 1
fi

echo "🧪 Running dry run..."
cargo publish --dry-run

echo ""
echo "🚀 Publishing to crates.io..."
cargo publish

echo ""
echo "✅ deckyfx-dioxus-ipc-bridge-macros published successfully!"
echo ""
echo "Verify at: https://crates.io/crates/deckyfx-dioxus-ipc-bridge-macros"
echo ""
