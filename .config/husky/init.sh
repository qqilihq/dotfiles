# Sourced by every husky hook (husky >= 9), whatever launched git -- so this is
# the only reliable place to put what a hook needs. A GUI git client or an IDE
# reads none of the shell config, `.zshenv` included.

# Prepended, matching `.zshrc`: appending means a `pnpm`/`node` sitting earlier on
# PATH (a brew-installed one, say) shadows Volta's shim, and the project's pinned
# version is never consulted at all.
export PATH="$HOME/.volta/bin:$PATH"

# Kept in sync with `.zshenv`, which covers non-interactive shells generally.
# Without this, Volta ignores a project's `volta.pnpm` pin and the `pnpm` shim
# fails with "Could not find executable" -- still gated as of Volta 2.0.2.
export VOLTA_FEATURE_PNPM=1
