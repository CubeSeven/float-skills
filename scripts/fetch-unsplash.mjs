#!/usr/bin/env node
/**
 * fetch-unsplash.mjs — Fetch contextual stock photos from Unsplash.
 *
 * Usage:
 *   node scripts/fetch-unsplash.mjs "greek island villa terrace" 6
 *
 * Requires:
 *   - UNSPLASH_ACCESS_KEY in .env (or exported)
 *
 * Output:
 *   - Writes content/images/unsplash-manifest.json
 *   - Caches results in content/images/.unsplash-cache.json
 *   - Per the rule file (§7.12), Unsplash images are HOTLINKED from the
 *     official CDN (do not download the binary — required by Unsplash ToS).
 */

import fs from 'node:fs/promises';

const CACHE_FILE = 'content/images/.unsplash-cache.json';
const MANIFEST_FILE = 'content/images/unsplash-manifest.json';
const OUT_DIR = 'content/images';

async function main() {
  const [query, countArg] = process.argv.slice(2);
  if (!query) {
    console.error('Usage: node scripts/fetch-unsplash.mjs "<search query>" [count]');
    process.exit(1);
  }

  const KEY = process.env.UNSPLASH_ACCESS_KEY;
  if (!KEY) {
    console.error('Missing UNSPLASH_ACCESS_KEY — add to .env or export it');
    process.exit(1);
  }

  await fs.mkdir(OUT_DIR, { recursive: true });

  // Load cache
  let cache = {};
  try {
    cache = JSON.parse(await fs.readFile(CACHE_FILE, 'utf8'));
  } catch {
    /* fresh start */
  }

  const count = parseInt(countArg ?? '6', 10);
  const results = [];

  if (cache[query]) {
    console.log(`Using cached results for "${query}"`);
    results.push(...cache[query]);
  } else {
    console.log(`Fetching "${query}" from Unsplash (${count} images)...`);
    const url = new URL('https://api.unsplash.com/search/photos');
    url.searchParams.set('query', query);
    url.searchParams.set('per_page', String(count));
    url.searchParams.set('orientation', 'landscape');
    url.searchParams.set('content_filter', 'high');

    const res = await fetch(url, {
      headers: { Authorization: `Client-ID ${KEY}` },
    });

    if (!res.ok) {
      console.error(`Unsplash ${res.status} ${res.statusText} for "${query}"`);
      process.exit(1);
    }

    const { results: photos } = await res.json();

    const mapped = photos.map((p) => ({
      id: p.id,
      raw: p.urls.raw,
      alt: p.alt_description || query + ' photo',
      credit: { name: p.user.name, url: p.user.links.html },
      blur_hash: p.blur_hash,
      width: p.width,
      height: p.height,
    }));

    cache[query] = mapped;
    results.push(...mapped);

    await new Promise((r) => setTimeout(r, 1000));
  }

  await fs.writeFile(CACHE_FILE, JSON.stringify(cache, null, 2));
  await fs.writeFile(MANIFEST_FILE, JSON.stringify(results, null, 2));

  console.log(`Fetched ${results.length} image(s) for "${query}"`);
  console.log(`  Manifest: ${MANIFEST_FILE}`);
  console.log(`  Cache:    ${CACHE_FILE}`);
  console.log('');
  console.log('Next: run `node scripts/process-images.mjs` to generate variants.');
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
