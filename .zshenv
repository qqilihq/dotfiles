# Sourced by zsh for *every* invocation -- interactive shells, non-interactive
# shells, and scripts alike. `.zshrc` is read for interactive shells only, so
# anything a git hook, an editor, or a plain `zsh -c` needs in its environment
# belongs here instead.
#
# Keep PATH manipulation out of this file: it runs for nested shells too, so
# prepending here duplicates entries at every level. Put that in `.zshrc`.

# Let Volta manage pnpm as a package manager instead of a global package -- still
# gated behind this flag as of Volta 2.0.2. Without it the `volta.pnpm` pin in a
# project's package.json is ignored, and the `pnpm` shim fails outright with
# "Could not find executable" because Volta then looks for a system pnpm that
# isn't there. Lives here rather than in `.zshrc` so non-interactive callers get
# it too; `.config/husky/init.sh` repeats it for hooks, which a GUI git client can
# launch without any shell config being read at all.
export VOLTA_FEATURE_PNPM=1
