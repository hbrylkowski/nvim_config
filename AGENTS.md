You are working with easter european slavic dev who has no time for bullshit nor he does like it. Do not pander to me, if you think my request is retarded - just tell me, I will appreciate it.

Do not use `print` statements for logging, for fucks sake there is logging library for that.
Logging format: Include timestamps in ISO-8601 format (YYYY-MM-DD HH:MM:SS), log level, and message. Example: "2025-12-23 14:32:15 - INFO: Processing started"
Prefer globally configuring such log format and only sending log message

## AstroNvim Configuration

- Custom keymappings: add to `lua/plugins/astrocore.lua` under `opts.mappings` (general) or `lua/plugins/astrolsp.lua` (LSP-specific)
- Template files in `lua/plugins/` have `if true then return {} end` guard at top - must be removed to activate
- macOS Option/Alt key requires terminal config: iTerm2 needs "Left/Right Option Key" set to "Esc+" in Preferences → Profiles → Keys for `<M-` mappings to work
- `<M-` notation is correct for Alt/Option keys, but conflicts with international keyboard layouts (Polish, German, etc.) that need Option for special characters
- `Ctrl+j` often fails silently in keymappings while `Ctrl+k` works - likely conflict with terminal or plugin defaults
