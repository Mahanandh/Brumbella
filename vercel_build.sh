#!/bin/bash

# Vercel doesn't have Flutter pre-installed, so we need to download it
echo "Installing Flutter..."
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable
fi

# Build the web app
echo "Building Flutter Web App..."
./flutter/bin/flutter build web --release
