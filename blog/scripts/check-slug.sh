#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

errors=0
warnings=0
slug_file="/tmp/cozyblog_slugs.$$"
> "$slug_file"
trap 'rm -f "$slug_file"' EXIT

get_slug() {
    local file="$1"
    local front_matter
    front_matter="$(sed -n '/^+++$/,/^+++$/p' "$file" | sed '1d;$d')"

    if echo "$front_matter" | grep -q 'slug[[:space:]]*='; then
        echo "$front_matter" | grep 'slug[[:space:]]*=' | head -1 | sed 's/.*slug[[:space:]]*=[[:space:]]*"\(.*\)".*/\1/'
    else
        basename "$file" .md | tr '[:upper:]' '[:lower:]' | tr ' ' '-'
    fi
}

check_file() {
    local file="$1"
    local basename
    basename="$(basename "$file" .md)"

    if [[ "$basename" == "_index" ]]; then
        return
    fi

    local front_matter
    front_matter="$(sed -n '/^+++$/,/^+++$/p' "$file" | sed '1d;$d')"

    local draft="false"
    if echo "$front_matter" | grep -q 'draft[[:space:]]*=[[:space:]]*true'; then
        draft="true"
    fi

    local has_slug="false"
    if echo "$front_matter" | grep -q 'slug[[:space:]]*='; then
        has_slug="true"
    fi

    if [[ "$draft" == "false" && "$has_slug" == "false" ]]; then
        echo "ERROR: $file — published post missing 'slug' in front matter"
        ((errors++))
    elif [[ "$draft" == "true" && "$has_slug" == "false" ]]; then
        echo "WARN:  $file — draft missing 'slug' (will be auto-derived from filename)"
        ((warnings++))
    fi

    if [[ "$draft" == "false" ]]; then
        local slug
        slug="$(get_slug "$file")"
        echo "$slug	$file" >> "$slug_file"
    fi
}

for section in blog chinese shorts; do
    dir="content/$section"
    if [[ -d "$dir" ]]; then
        while IFS= read -r -d '' file; do
            check_file "$file"
        done < <(find "$dir" -maxdepth 1 -name '*.md' -print0)
    fi
done

sort "$slug_file" | awk -F'	' '{slug=$1; file=$2; if(slug==prev) {if(!reported) {print "ERROR: duplicate slug '\''" slug "'\'' in:"; print "       " prev_file} print "       " file; count++} prev=slug; prev_file=file; reported=(slug==prev)} END {exit count>0}' && true
dupes=$?
if [[ $dupes -ne 0 ]]; then
    ((errors++))
fi

echo ""
echo "Slug check complete: $errors error(s), $warnings warning(s)"

if [[ $errors -gt 0 ]]; then
    exit 1
fi
