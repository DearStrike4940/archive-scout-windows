from pathlib import Path
import sys

if len(sys.argv) != 2:
    raise SystemExit("Usage: python scripts/set_github_username.py YOUR_GITHUB_USERNAME")
username = sys.argv[1].strip()
if not username:
    raise SystemExit("Username cannot be blank")
root = Path(__file__).resolve().parents[1]
for relative in ("README.md", "REPOSITORY_DETAILS.md", "docs/GITHUB_SETUP.md"):
    path = root / relative
    text = path.read_text(encoding="utf-8")
    text = text.replace("YOUR_GITHUB_USERNAME", username)
    path.write_text(text, encoding="utf-8")
print("Updated GitHub links for", username)
print("Latest asset: https://github.com/" + username + "/archive-scout-windows/releases/latest/download/ArchiveScout-Windows-x64.zip")
