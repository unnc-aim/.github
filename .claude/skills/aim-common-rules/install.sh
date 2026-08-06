#!/usr/bin/env bash
#
# aim-common-rules — interactive installer
#
# Installs the UNNC AIM team standards skill (or, for non-Claude-Code members,
# just the formatting rules) to a destination of your choice.
#
# Interactive by default when run in a terminal. Non-interactive (defaults to a
# global Claude Code install) when piped, e.g.:
#   curl -fsSL https://raw.githubusercontent.com/unnc-aim/.github/main/.claude/skills/aim-common-rules/install.sh | bash
#
# Non-interactive overrides (for CI / scripting):
#   AIM_INSTALL_CHOICE=1|2|3|4|5 bash install.sh   # pick a menu option
#   AIM_INSTALL_DEST=/any/path     bash install.sh   # equivalent to option 5
#
# Re-running this installer updates to the latest version.
#
set -euo pipefail

SKILL="aim-common-rules"
REPO="https://github.com/unnc-aim/.github.git"
BRANCH="main"

# --- locate skill source: prefer a local copy, else shallow-clone the repo ---
# When piped to bash via curl, BASH_SOURCE is unavailable, so the clone path is used.
SELF_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ]; then
  SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)" || SELF_DIR=""
fi

if [ -n "$SELF_DIR" ] && [ -f "$SELF_DIR/SKILL.md" ] && [ -d "$SELF_DIR/assets" ]; then
  SRC="$SELF_DIR"
else
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  git clone --quiet --depth 1 --branch "$BRANCH" "$REPO" "$TMP/repo"
  SRC="$TMP/repo/.claude/skills/$SKILL"
fi

if [ ! -f "$SRC/SKILL.md" ]; then
  echo "Error: skill source not found at $SRC" >&2
  exit 1
fi

# --- interactive destination menu ---
# All user-facing text goes to stderr; only the chosen number (1-5) is echoed to
# stdout so command substitution captures just the choice.
choose() {
  cat >&2 <<'EOF'

Where do you want to install aim-common-rules?

  1) ~/.claude/skills/         Global — Claude Code (all your projects)        [recommended]
  2) ./.claude/skills/         This project — Claude Code (commit it for the team)
  3) ./.agents/                Generic agent dir (Cursor / Cline / custom tools)
  4) Repo root (rules only)    Copy .clang-format / .clang-tidy / setup.cfg to ./
                              (best if you do NOT use Claude Code)
  5) Custom path               Install the full skill to a directory you choose

EOF
  local choice=""
  while true; do
    printf 'Choice [1-5, default 1]: ' >&2
    if ! read -r choice < /dev/tty 2>/dev/null; then
      choice="1"
    fi
    choice="${choice:-1}"
    case "$choice" in
      1|2|3|4|5) echo "$choice"; return 0 ;;
      *) echo "Please enter a number 1-5." >&2 ;;
    esac
  done
}

# --- resolve the chosen action ---
if [ -n "${AIM_INSTALL_DEST:-}" ]; then
  CHOICE="5"
elif [ -n "${AIM_INSTALL_CHOICE:-}" ]; then
  CHOICE="$AIM_INSTALL_CHOICE"
elif [ -t 0 ] && [ -t 1 ]; then
  CHOICE="$(choose)"
else
  CHOICE="1"   # non-interactive default (curl | bash, CI)
  echo "Non-interactive mode: defaulting to option 1 (global ~/.claude/skills)." >&2
fi

# --- actions ---
copy_full_skill() {   # $1 = destination directory
  local d="$1"
  mkdir -p "$d"
  rm -rf "$d/$SKILL"
  cp -R "$SRC" "$d/$SKILL"
  echo "Installed '$SKILL' -> $d/$SKILL"
}

copy_rules_only() {
  local assets="$SRC/assets"
  local f
  for f in .clang-format .clang-tidy setup.cfg; do
    [ -f "$assets/$f" ] || continue
    if [ -e "./$f" ]; then
      # Never clobber an existing file (e.g. a ROS setup.cfg) — write alongside.
      cp "$assets/$f" "./$f.aim-common-rules"
      echo "  ./$f already exists — wrote rules to ./$f.aim-common-rules (merge manually)."
    else
      cp "$assets/$f" "./$f"
      echo "  wrote ./$f"
    fi
  done
}

case "$CHOICE" in
  1)
    DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
    copy_full_skill "$DEST"
    echo "Available in all your Claude Code projects (auto-triggered)."
    ;;
  2)
    copy_full_skill "./.claude/skills"
    echo "Available in this project only. Commit it so teammates get it too."
    ;;
  3)
    copy_full_skill "./.agents"
    echo "Installed under ./.agents/. Point your tool at SKILL.md / assets as needed."
    ;;
  4)
    echo "Copying formatting rules to repo root..."
    copy_rules_only
    echo "Done. Your editor / clang-format / autopep8 / CI will read these automatically."
    echo "(Non-Claude-Code setup complete.)"
    ;;
  5)
    DEST="${AIM_INSTALL_DEST:-}"
    if [ -z "$DEST" ]; then
      if [ -t 0 ] && [ -t 1 ]; then
        while true; do
          printf 'Enter destination directory: ' >&2
          if ! read -r DEST < /dev/tty 2>/dev/null; then
            echo "Error: no input." >&2; exit 1
          fi
          [ -n "$DEST" ] && break
          echo "Please enter a path." >&2
        done
      else
        echo "Error: choice 5 requires AIM_INSTALL_DEST=<path> in non-interactive mode." >&2
        exit 1
      fi
    fi
    copy_full_skill "$DEST"
    ;;
  *)
    echo "Error: invalid choice '$CHOICE' (expected 1-5). Use AIM_INSTALL_CHOICE=1..5." >&2
    exit 1
    ;;
esac

echo ""
echo "Re-run this installer any time to update."
