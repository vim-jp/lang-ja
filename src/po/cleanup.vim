" Vim script to cleanup a .po file:
" - Remove line numbers (avoids that diffs are messy).
" - Comment-out fuzzy and empty messages.
" - Make sure there is a space before the string (required for Solaris).
" Requires Vim 6.0 or later (because of multi-line search patterns).

" Disable diff mode, because it makes this very slow
let s:was_diff = &diff
setl nodiff

" untranslated message preceded by c-format or comment
silent keeppatterns g/^#, c-format\n#/.d
silent keeppatterns g/^#\..*\n#/.d

silent keeppatterns g/^#[:~] /d
silent keeppatterns g/^#, fuzzy\(, .*\)\=\nmsgid ""\@!/keeppatterns .+1,/^$/-1s/^/#\~ /
silent keeppatterns g/^msgstr"/keeppatterns s//msgstr "/
silent keeppatterns g/^msgid"/keeppatterns s//msgid "/
silent keeppatterns g/^msgstr ""\(\n"\)\@!/keeppatterns ?^msgid?,.s/^/#\~ /

silent keeppatterns g/^\n\n\n/.d

if s:was_diff
  setl diff
endif
