# Jitsi

A free and open-source multiplatform voice, video conferencing and instant messaging application.

## Building

Build the application by executing: `build.sh`

Push to device with:

```bash
adb push nl.btr.appName_1.0.0_arm64.click
```

Open device with adb shell and execute:

```bash
pkcon install-local --allow-untrusted nl.btr.appName_1.0.0_arm64.click
```

Build pushHelper by executing:

```bash
cd pushnotifications/executable/ && qtdeploy build
```

## JS development

Install the needed dependencies using:

```bash
npm install # or pnpm
```

bundle JavaScript and css files using:

```bash
npm run build
```

### Development

To watch the JavaScript and css files and automatically bundle them you can use:

```bash
npm run dev
```

You can also add the optional `--cp` or `--copy` flag to this command to automactically copy the bundled JavaScript payload to your clipboard and easily paste it in the browser, ex: `npm run dev --copy`
