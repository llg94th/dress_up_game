#!/bin/bash

# Build script for GitHub Pages deployment
# This builds the Flutter web app with custom base href for GitHub Pages

echo "🚀 Building Dress Up Game for GitHub Pages..."
echo "📍 Base URL: /dress_up_game/"
echo "📂 Output: docs/"

# Clean previous build
echo "🧹 Cleaning previous build..."
rm -rf docs/

# Build with custom base href for GitHub Pages
echo "🔨 Building Flutter web app..."
flutter build web --release --base-href="/dress_up_game/" --output=docs

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "📦 Files generated in 'docs/' folder"
    echo "🌐 Ready for GitHub Pages deployment"
    echo ""
    echo "📋 Next steps:"
    echo "   1. Commit and push to GitHub"
    echo "   2. Enable GitHub Pages from 'docs' folder"
    echo "   3. Access at: https://yourusername.github.io/dress_up_game/"
else
    echo "❌ Build failed!"
    exit 1
fi 