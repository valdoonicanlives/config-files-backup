" AUTOCOMMANDS
if has("autocmd")
  augroup filetypedetect
    au BufEnter *.markdown,*.mkd,*.mdown,*.md setl wrap tw=79
    au BufEnter *.json setl ft=javascript
    au BufEnter *.md setl ft=markdown
    au BufEnter *.t2t setl ft=txt2tags
    au BufEnter *.py setl ts=4 sw=4 sts=4
    au BufEnter *.php setl ts=4 sw=4 sts=4
    au BufEnter *.js setl ts=2 sw=2 sts=2
    au BufEnter *.html setl ts=4 sw=4 sts=4
    au BufEnter *.tex setl wrap tw=79 fo=tcqor
    au BufEnter Makefile setl ts=4 sts=4 sw=4 noet list
  augroup END
"so that you can add folds to your vimrc to make it tidy (use za to toggle fold)
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
"-----------------------------------------
" line below for use with mutt
autocmd BufNewFile,BufRead /tmp/mutt-* set filetype=mail
" or try au BufRead mutt-*        set ft=mail
" Read word documents-have installed antiword DK
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"
"below 3 lines to show sytax highlighting for markdown files with .mkd  extension
augroup mkd
autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
augroup END
"======================================================
endif
