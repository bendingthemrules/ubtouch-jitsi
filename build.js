import fs from 'node:fs';
import esbuild from 'esbuild';
import { sassPlugin } from 'esbuild-sass-plugin';
import clipboard from 'clipboardy';

console.time('bundled in');

// bundle js and css payload
await esbuild.build({
  entryPoints: ['./payload/index.js', './payload/style.scss'],
  plugins: [sassPlugin()],
  bundle: true,
  minify: true,
  // outfile: './assets/bundle.js',
  outdir: './build',
});

// read and combine esbuild output files
const js = fs.readFileSync('./build/index.js');
const css = fs.readFileSync('./build/style.css').toString().trimEnd();

const cssPayload = `document.head.appendChild(document.createElement("style")).appendChild(document.createTextNode(\`${css}\`));`;

const out = `${cssPayload}\n${js}`;

fs.writeFileSync('./assets/bundle.js', out);
// remove temp files, can give an error when building to fast in succession
// fs.unlinkSync('./build/index.js');
// fs.unlinkSync('./build/style.css');

console.timeEnd('bundled in');

if (process.argv.find((arg) => arg === '--cp' || arg === '--copy'))
  clipboard.writeSync(out); // copies content to clipboard
