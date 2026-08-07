#!/usr/bin/env bash
#
# aim-common-rules — interactive installer
#
# Installs the UNNC AIM team standards skill to a destination of your choice.
#
# Interactive by default when run in a terminal. Non-interactive (defaults to a
# global Claude Code install) when piped, e.g.:
#   curl -fsSL https://raw.githubusercontent.com/unnc-aim/.github/main/.agent/skills/aim-common-rules/install.sh | bash
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
  SRC="$TMP/repo/.agent/skills/$SKILL"
fi

if [ ! -f "$SRC/SKILL.md" ]; then
  echo "Error: skill source not found at $SRC" >&2
  exit 1
fi

# --- interactive destination menu ---
# All user-facing text goes to stderr; only the chosen number (1-4) is echoed to
# stdout so command substitution captures just the choice.
choose() {
  cat >&2 <<'EOF'

Where do you want to install aim-common-rules?

  1) ~/.claude/skills/         Global — Claude Code (all your projects)        [recommended]
  2) ./.claude/skills/         This project — Claude Code (commit it for the team)
  3) .agent/skills/            Generic agent dir (global ~/.agent or project ./.agent; Cursor / Cline / custom)
  4) Custom path               Install the full skill to a directory you choose

EOF
  local choice=""
  while true; do
    printf 'Choice [1-4, default 1]: ' >&2
    if ! read -r choice < /dev/tty 2>/dev/null; then
      choice="1"
    fi
    choice="${choice:-1}"
    case "$choice" in
      1|2|3|4) echo "$choice"; return 0 ;;
      *) echo "Please enter a number 1-4." >&2 ;;
    esac
  done
}

# --- resolve the chosen action (interactive menu only; no env vars) ---
if [ -t 0 ] && [ -t 1 ]; then
  CHOICE="$(choose)"
else
  CHOICE="1"   # non-interactive default (curl | bash, CI)
  echo "Non-interactive mode: defaulting to option 1 (global ~/.claude/skills)." >&2
  echo "Run in a terminal to choose a different destination." >&2
fi

# --- copy the whole skill folder to a destination directory ---
copy_full_skill() {   # $1 = destination directory
  local d="$1"
  mkdir -p "$d"
  rm -rf "$d/$SKILL"
  cp -R "$SRC" "$d/$SKILL"
  echo "Installed '$SKILL' -> $d/$SKILL"
}

case "$CHOICE" in
  1)
    copy_full_skill "$HOME/.claude/skills"
    echo "Available in all your Claude Code projects (auto-triggered)."
    ;;
  2)
    copy_full_skill "./.claude/skills"
    echo "Available in this project only. Commit it so teammates get it too."
    ;;
  3)
    # Generic agent dir: global (~/.agent/skills) or project (./.agent/skills).
    AGENT_SCOPE=""
    if [ -t 0 ] && [ -t 1 ]; then
      cat >&2 <<'EOF'

Install the agent skill dir where?
  g) ~/.agent/skills/   Global (all your projects)
  p) ./.agent/skills/   This project

EOF
      while true; do
        printf 'Choice [g/p, default g]: ' >&2
        if ! read -r AGENT_SCOPE < /dev/tty 2>/dev/null; then
          AGENT_SCOPE="g"
        fi
        AGENT_SCOPE="${AGENT_SCOPE:-g}"
        case "$AGENT_SCOPE" in
          g|G|p|P) break ;;
          *) echo "Please enter g or p." >&2 ;;
        esac
      done
    else
      AGENT_SCOPE="g"   # non-interactive fallback (option 3 is normally interactive-only)
    fi
    case "$AGENT_SCOPE" in
      g|G) AGENT_DEST="$HOME/.agent/skills" ;;
      *)   AGENT_DEST="./.agent/skills" ;;
    esac
    copy_full_skill "$AGENT_DEST"
    echo "Installed under $AGENT_DEST. Point your tool at SKILL.md / assets as needed."
    ;;
  4)
    if [ -t 0 ] && [ -t 1 ]; then
      DEST=""
      while true; do
        printf 'Enter destination directory: ' >&2
        if ! read -r DEST < /dev/tty 2>/dev/null; then
          echo "Error: no input." >&2; exit 1
        fi
        [ -n "$DEST" ] && break
        echo "Please enter a path." >&2
      done
    else
      echo "Error: custom path requires an interactive terminal." >&2
      exit 1
    fi
    copy_full_skill "$DEST"
    ;;
  *)
    echo "Error: invalid choice '$CHOICE' (expected 1-4). Run interactively to choose." >&2
    exit 1
    ;;
esac

echo ""
echo "Re-run this installer any time to update."
