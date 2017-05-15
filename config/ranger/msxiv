#!/bin/sh
target="$(realpath -s "$1")"
[ "$1" == '--' ] && shift
function listfiles {
  find "$(dirname "$target")" -maxdepth 1 -type f -regex '.*\(jpe?g\|png\|gif\)$' -print0 | sort -z
}
count="$(listfiles | grep -m 1 -Zznx "$target" | cut -d: -f1)"

if [ -n "$count" ]; then
  listfiles | xargs -0 sxiv -n "$count" --
else
  sxiv -- "$@" # fallback
fi
