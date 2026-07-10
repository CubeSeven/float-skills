#!/usr/bin/env node
/**
 * optimize-images.mjs — Convert a folder of source JPEGs/PNGs
 * to optimized WebP files in place. Use for client-supplied
 * hero/gallery photos before wiring them up in gallery.ts.
 *
 * Usage:
 *   node scripts/optimize-images.mjs dir public/images/source
 *   node scripts/optimize-images.mjs image public/images/source/hero.jpg
 */

import sharp from 'sharp';
import fs from 'node:fs/promises';
import path from 'node:path';

const SUPPORTED = new Set(['.jpg', '.jpeg', '.png', '.tiff']);

async function optimizeOne(inputPath, outDir) {
  const ext = path.extname(inputPath).toLowerCase();
  if (!SUPPORTED.has(ext)) return null;

  const baseName = path.basename(inputPath, ext);
  const outPath = path.join(outDir, `${baseName}.webp`);

  const before = (await fs.stat(inputPath)).size;

  const info = await sharp(inputPath)
    .rotate()
    .resize({ width: 1600, withoutEnlargement: true })
    .webp({ quality: 75, effort: 6 })
    .toFile(outPath);

  const after = (await fs.stat(outPath)).size;

  return {
    input: path.basename(inputPath),
    output: path.basename(outPath),
    width: info.width,
    height: info.height,
    before: before / 1024,
    after: after / 1024,
    saved: Math.round((1 - after / before) * 100) + '%',
  };
}

async function runDir(target) {
  const exists = await fs.stat(target).catch(() => null);
  if (!exists) {
    console.error(`Directory not found: ${target}`);
    process.exit(1);
  }
  const outDir = target + '/optimized';
  await fs.mkdir(outDir, { recursive: true });
  const entries = await fs.readdir(target, { withFileTypes: true });
  const results = [];
  for (const e of entries) {
    if (!e.isFile()) continue;
    const p = path.join(target, e.name);
    const r = await optimizeOne(p, outDir);
    if (r) results.push(r);
  }
  if (results.length === 0) {
    console.log('No source images found.');
    return;
  }
  console.table(results);
  console.log(`Done. Output: ${outDir}`);
}

async function runImage(target) {
  const exists = await fs.stat(target).catch(() => null);
  if (!exists) {
    console.error(`File not found: ${target}`);
    process.exit(1);
  }
  const outDir = path.dirname(target);
  const r = await optimizeOne(target, outDir);
  if (r) console.log(r);
}

async function main() {
  const [command, target] = process.argv.slice(2);
  if (command === 'dir' && target) {
    await runDir(target);
  } else if (command === 'image' && target) {
    await runImage(target);
  } else {
    console.log('Usage:');
    console.log('  node scripts/optimize-images.mjs dir  <folder>');
    console.log('  node scripts/optimize-images.mjs image <file>');
    process.exit(1);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
