#!/usr/bin/env bash
# Import skills from this library into a project's .claude/skills/.
#
#   ./scripts/install.sh --list
#   ./scripts/install.sh fable-mode grill-me
#   ./scripts/install.sh --all --target /path/to/project/.claude/skills
#
# Copies plain files you own and can edit. Re-run with --force to update.
set -euo pipefail

LIB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_ROOT="$LIB_ROOT/skills"
TARGET=".claude/skills"
LOCKFILE_NAME=".innohub-skills.lock"
FORCE=0
ALL=0
WANTED=()

usage() {
  sed -n '2,9p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
  exit "${1:-0}"
}

# --- discover: "<name>\t<category>\t<abs path>" per installable skill
discover() {
  find "$SKILLS_ROOT" -mindepth 2 -maxdepth 2 -type d -print0 \
    | while IFS= read -r -d '' dir; do
        [ -f "$dir/SKILL.md" ] || continue
        printf '%s\t%s\t%s\n' "$(basename "$dir")" "$(basename "$(dirname "$dir")")" "$dir"
      done | sort
}

describe() { # first `description:` line of the frontmatter, truncated
  sed -n 's/^description: *//p' "$1/SKILL.md" | head -1 | cut -c1-100
}

while [ $# -gt 0 ]; do
  case "$1" in
    --list|-l)   discover | while IFS=$'\t' read -r n c d; do
                   printf '  %-24s %-14s %s\n' "$n" "[$c]" "$(describe "$d")"
                 done
                 exit 0 ;;
    --all|-a)    ALL=1; shift ;;
    --force|-f)  FORCE=1; shift ;;
    --target|-t) TARGET="$2"; shift 2 ;;
    --help|-h)   usage 0 ;;
    -*)          echo "unknown flag: $1" >&2; usage 1 ;;
    *)           # tolerate `a, b` as well as `a b`
                 IFS=', ' read -ra _parts <<< "$1"
                 for p in "${_parts[@]}"; do [ -n "$p" ] && WANTED+=("$p"); done
                 shift ;;
  esac
done

if [ "$ALL" -eq 0 ] && [ "${#WANTED[@]}" -eq 0 ]; then
  echo "Nothing to do. Pick skills, or use --all. Available:" >&2
  discover | while IFS=$'\t' read -r n c d; do printf '  %-24s [%s]\n' "$n" "$c"; done >&2
  exit 1
fi

COMMIT="$(git -C "$LIB_ROOT" rev-parse --short HEAD 2>/dev/null || echo unknown)"
STAMP="$(date +%F)"
mkdir -p "$TARGET"
LOCKFILE="$TARGET/$LOCKFILE_NAME"
[ -f "$LOCKFILE" ] || printf '# skill\tcommit\timported\n' > "$LOCKFILE"

installed=0
while IFS=$'\t' read -r name category dir; do
  if [ "$ALL" -eq 0 ]; then
    match=0
    for w in "${WANTED[@]}"; do [ "$w" = "$name" ] && match=1; done
    [ "$match" -eq 1 ] || continue
  fi

  dest="$TARGET/$name"
  if [ -e "$dest" ] && [ "$FORCE" -eq 0 ]; then
    echo "  skip  $name (already present — pass --force to overwrite)"
    continue
  fi

  rm -rf "$dest"
  cp -r "$dir" "$dest"
  # drop any previous row for this skill, then re-add. awk, not `grep -P`: the latter
  # is unavailable in some Git Bash locales and its failure silently duplicates rows.
  awk -F'\t' -v n="$name" '$1 != n' "$LOCKFILE" > "$LOCKFILE.tmp"
  printf '%s\t%s\t%s\n' "$name" "$COMMIT" "$STAMP" >> "$LOCKFILE.tmp"
  mv "$LOCKFILE.tmp" "$LOCKFILE"
  echo "  ok    $name  [$category]  @ $COMMIT"
  installed=$((installed + 1))
done < <(discover)

# unknown names the user asked for
if [ "$ALL" -eq 0 ]; then
  known="$(discover | cut -f1)"
  for w in "${WANTED[@]}"; do
    echo "$known" | grep -qx "$w" || echo "  ??    $w — no such skill in this library" >&2
  done
fi

echo
echo "$installed skill(s) → $TARGET (tracked in $LOCKFILE_NAME)"
echo "Restart your agent session so it picks them up."
