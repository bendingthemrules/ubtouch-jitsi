#!/bin/bash
set -e

npm ci
npm run build

qtdeploy build
mkdir -p build

cp manifest.json build
cp jitsi.apparmor build
cp jitsi.desktop build

cp deploy/linux/jitsi-client build
mv build/jitsi-client build/jitsi

cp -R assets build

cd build && click build .
