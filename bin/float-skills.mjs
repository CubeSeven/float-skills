#!/usr/bin/env node
/**
 * float-skills CLI — minimal wrapper for common tasks.
 * Real logic lives in scripts/ — this is just a friendly entry point.
 */

import { spawnSync } from 'node:child_process';
import fs from 'node:fs';

const commands = {
  setup: 'bash scripts/setup.sh',
  'sync-rules': 'bash scripts/sync-rules.sh',
  'fetch-images': 'node scripts/fetch-unsplash.mjs',
  'optimize-images': 'node scripts/optimize-images.mjs',
  'process-images': 'node scripts/process-images.mjs',
  validate: 'bash scripts/validate-project.sh',
  'post-setup': 'bash scripts/generate-post-setup.sh',
};

const args = process.argv.slice(2);
const cmd = args[0] || 'help';

if (cmd === 'help' || !commands[cmd]) {
  console.log('float-skills — Float Creatives brochure-site toolkit\n');
  console.log('Usage: float-skills <command>\n');
  console.log('Commands:');
  for (const [key, value] of Object.entries(commands)) {
    console.log(`  ${key.padEnd(16)} ${value}`);
  }
  console.log('\nRun `float-skills setup` to scaffold a new project.');
  process.exit(cmd === 'help' ? 0 : 1);
}

const script = commands[cmd];
console.log(`▶  ${script}`);
const [bin, ...rest] = script.split(' ');
const result = spawnSync(bin, rest, { stdio: 'inherit', shell: true });
process.exit(result.status ?? 0);