const fs = require("fs");
const path = require("path");

function shaFromAsset(asset) {
  const d = asset.digest ?? "";
  return d.startsWith("sha256:") ? d.slice(7) : d;
}

function escapeRegex(s) {
  return s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

async function main() {
  const formulaId = process.argv[2];
  const repo = process.argv[3];
  if (!formulaId || !repo) {
    console.error("Usage: node update-formula.js <formula-id> <owner/repo>");
    process.exit(1);
  }

  const formulaPath = path.join(__dirname, "../../Formula", `${formulaId}.rb`);
  const releaseApi = `https://api.github.com/repos/${repo}/releases/latest`;

  let content = fs.readFileSync(formulaPath, "utf8");
  const markerPrefix = formulaId;
  const keyRe = new RegExp(`# ${escapeRegex(markerPrefix)}:(\\S+)`, "g");
  const keys = [...content.matchAll(keyRe)].map((m) => m[1]);
  const uniqueKeys = [...new Set(keys)];

  const res = await fetch(releaseApi);
  if (!res.ok) throw new Error(`GitHub API error: ${res.status}`);
  const release = await res.json();

  const version = release.tag_name.replace(/^v/, "");
  const assetsByName = Object.fromEntries(release.assets.map((a) => [a.name, a]));

  const replacements = {};
  for (const key of uniqueKeys) {
    if (key === "version") {
      replacements.version = version;
      continue;
    }
    if (key.startsWith("url-")) {
      const assetName = key.slice(4) + "-" + formulaId;
      if (!assetsByName[assetName]) throw new Error(`Missing release asset: ${assetName}`);
      replacements[key] = assetsByName[assetName].browser_download_url;
      continue;
    }
    if (key.startsWith("sha-")) {
      const assetName = key.slice(4) + "-" + formulaId;
      if (!assetsByName[assetName]) throw new Error(`Missing release asset: ${assetName}`);
      replacements[key] = shaFromAsset(assetsByName[assetName]);
    }
  }

  const lineRe = new RegExp(
    `^(\\s*\\w+\\s*)"([^"]*)"(\\s*# ${escapeRegex(markerPrefix)}:(\\S+).*)$`,
    "gm"
  );
  content = content.replace(lineRe, (match, prefix, _old, suffix, key) => {
    if (!(key in replacements)) return match;
    return `${prefix}"${replacements[key]}"${suffix}`;
  });
  fs.writeFileSync(formulaPath, content);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
