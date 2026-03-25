#!/bin/sh
printf '\033c\033]0;%s\a' InfoGameFr
base_path="$(dirname "$(realpath "$0")")"
"$base_path/a_Cat_Cating_around.x86_64" "$@"
