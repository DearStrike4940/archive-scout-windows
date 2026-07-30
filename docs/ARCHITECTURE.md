# Architecture

## Components

- `archive_scout/app.py`: cross-platform Tkinter desktop interface, project editing, progress display, and saved UI state.
- `archive_scout/engine.py`: CDX queries, validation, native certificate trust, SQLite state, concurrent downloads, scanning, scoring, and reports.
- `archive_scout/defaults.py`: editable presets.
- `archive_scout/cli.py`: optional command-line runner for saved `project.json` files.
- `run_app.py`: PyInstaller entry point.
- `scripts/build_windows.ps1`: Windows x64 one-folder package and installer ZIP.

## Data flow

1. Normalize targets, dates, CDX parameters, and keywords.
2. Compute a query signature so incompatible CDX settings do not reuse old resume state.
3. Query CDX in yearly windows using resume keys.
4. Upsert the earliest capture for each original URL.
5. Select text-like captures for download.
6. Fetch raw replay content with bounded concurrency, native certificate verification, and shared rate limiting.
7. Extract title, visible text, and links.
8. Scan URL, title, text, source, and links.
9. Save capture text and analysis state.
10. Generate plain-text reports.

## Reliability

- SQLite uses WAL mode.
- CDX progress is committed after every response page.
- Interrupted downloads resume safely.
- Retryable HTTP responses use exponential backoff and `Retry-After`.
- A shared limiter spaces requests across worker threads.
- Response and local-file sizes are bounded.
- Temporary writes are atomically replaced.
- `truststore` uses the operating system certificate store rather than disabling verification.

## Packaging

PyInstaller uses `--onedir` for faster repeated launches instead of unpacking a one-file runtime every time. The workflow builds on `windows-2025` x64, creates a PyInstaller one-folder bundle for faster startup, adds per-user install and uninstall scripts, and produces a release ZIP.
