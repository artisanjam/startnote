# Functions for starting timestamped Markdown notes in Vim.
#
# Author: Jay P.
# Date: 2026-10-24

source timestamps.bash

# Make a string friendly to filenames and URLs.
slugify() {
  printf '%s' "$1" | \
    tr "[:upper:]" "[:lower:]" | \
    sed "s/+/plus/g
         s/&/and/g" |
    tr -d "[:punct:]" | \
    tr "[:blank:]" "-" | \
    sed "s/-\+/-/g
         s/^-//
         s/-$//"
}

# Duplicate apostrophes to escape them in Vimscript.
vimscript_escape() {
  printf '%s' "$1" | sed "s/'/''/g"
}

# Start a timestamped Markdown note in Vim.
#
# The filename gets a short UTC timestamp, while a longer, human-
# readable timestamp will appear in the document header.
#
# Arguments: $1 -> Title in natural language for the Markdown header.
#            $2 -> A summary which appears below the header as a
#                  paragraph block in Markdown.
startnote() {
  local title
  local filename
  local summary
  local vim_append

  title="$(vimscript_escape "$1")"
  filename="$(minstamp)_$(slugify "$1").md"
  if [ -n "$2" ]; then
    summary="$(vimscript_escape "$2")"
    vim_append="['# $title $(timestamp)', '', '$summary', '']"
  else
    vim_append="['# $title $(timestamp)', '']"
  fi
  vim -c "file $filename" \
      -c "setfiletype markdown" \
      -c "call append(0, $vim_append)"
}
