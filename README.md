# What's this?

This plugin shares command-line history between multiple Vims like bash's 'histappend' option.
It executes `:rviminfo` before entering command-line,
and executes `:wviminfo` after executing an Ex command.

# Goals

1. [x] Do not override user's mapping in .vimrc
2. [x] Correct [count] handling
3. [x] Correct abbreviation expansion handling
