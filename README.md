# Archive Scout for Windows

[Download the latest release](https://github.com/DearStrike4940/archive-scout-windows/releases/latest/download/ArchiveScout-Windows-x64.zip)


Archive Scout is a desktop interface for researching public Wayback Machine captures. It can index multiple domains and paths, apply traditional CDX parameters, download archived text pages concurrently, scan them for custom keywords or regular expressions, resume interrupted work through SQLite, and produce plain UTF-8 text reports.

## Main features

- Multiple Wayback targets and path patterns
- Exact CDX start and end dates
- Repeated `filter` parameters
- `collapse=urlkey` and `collapse=digest`
- `matchType` selection
- Validated advanced `key=value` CDX parameters
- Earliest capture per normalized URL
- Resumable indexing and downloads
- Concurrent bounded downloads
- Immediate keyword scanning during download
- URL-only fast mode
- Plain-text ranked reports
- Native system certificate trust through `truststore`
- Included Ogrish September 11 research preset

## CDX fields available in the interface

The CDX Options tab supports dates in `YYYY`, `YYYYMM`, `YYYYMMDD`, or `YYYYMMDDhhmmss` format, repeated filters, collapse options, match type, page size, and additional decoded parameters. Reserved parameters required by Archive Scout's JSON and resume parser cannot be overridden.

## Output

Each project folder contains a resumable SQLite database, downloaded captures, the saved project configuration, and reports including:

- `matches_ranked.txt`
- `matched_urls.txt`
- `wayback_urls.txt`
- `interesting_links.txt`
- `keyword_counts.txt`
- `all_indexed_urls.txt`
- `errors.txt`
- `summary.txt`

## Responsible use

Archive Scout is intended for research and preservation of public archived material. Use conservative worker counts and delays, respect rate limits, and do not use it to bypass access controls.


## Installation

Download and extract the release ZIP, then double-click **Install Archive Scout.cmd**. It installs the faster one-folder application under your user profile and creates Start Menu and desktop shortcuts. No administrator access is required. Use the installed **Uninstall Archive Scout** shortcut to remove it.

## Create the GitHub repository

1. Unzip this repository package.
2. Show hidden files and confirm `.github/workflows/` is present.
3. Run `python3 scripts/set_github_username.py DearStrike4940` or replace the placeholder manually.
4. Create an empty public repository named `archive-scout-windows`.
5. Upload every file and folder, including `.github`. Git is preferred because `git add .` includes hidden files.
6. In repository settings, enable GitHub Actions and set Workflow permissions to **Read and write permissions**.
7. Open **Actions**, select **Build Windows x64 App**, and run it from `main`.
8. Download and test the workflow artifact.
9. Create a release tag such as `v1.2.0`; the tag build uploads the release asset automatically.

See `docs/GITHUB_SETUP.md` for the complete click-by-click process.

## Source execution

Python 3.11 or newer is required.

```bash
python -m pip install -r requirements-runtime.txt
python run_app.py
```

## Testing

```bash
python -m unittest discover -s tests -v
```

## License

MIT
