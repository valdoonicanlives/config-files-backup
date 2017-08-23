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
"put in ~/.vimrc to save folds automatically
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview
" better colors for the folding
hi Folded cterm=bold ctermfg=DarkBlue ctermbg=none
hi FoldColumn cterm=bold ctermfg=DarkBlue ctermbg=none

" below for use with ccrypt with files ending with .cpt extension
augroup CPT
  au!
  au BufReadPre *.cpt set bin
  au BufReadPre *.cpt set viminfo=
  au BufReadPre *.cpt set noswapfile
  au BufReadPost *.cpt let $vimpass = inputsecret("Password: ")
  au BufReadPost *.cpt silent '[,']!ccrypt -cb -E vimpass
  au BufReadPost *.cpt set nobin
  au BufWritePre *.cpt set bin
  au BufWritePre *.cpt silent! '[,']!ccrypt -e -E vimpass
  au BufWritePost *.cpt silent! u
  au BufWritePost *.cpt set nobin
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
"Trying these below foruse with markdown files, yes below works when you are in insert mode
"autocmd BufReadPre *.mkd inoremap ,h  ##<Space>##<Esc>
"autocmd BufReadPre *.mkd inoremap ,b  **<Space>**<Esc>
"autocmd BufReadPre *.md inoremap ,h  ##<Space>##<Esc>
"autocmd BufReadPre *.md inoremap ,b  **<Space>**<Esc>
autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap ,b ****<Space><Esc>F*hi
autocmd Filetype markdown inoremap ,s ~~~~<Space><Esc>F~hi
autocmd Filetype markdown inoremap ,e **<Space><Esc>F*i
autocmd Filetype markdown inoremap ,h ====<Space><Esc>F=hi
autocmd Filetype markdown inoremap ,1 #<Space><Enter><Esc>kA
autocmd Filetype markdown inoremap ,2 ##<Space><Enter><Esc>kA
autocmd Filetype markdown inoremap ,3 ###<Space><Enter><Esc>kA
autocmd Filetype markdown inoremap ,l --------<Enter>
"======================================================
" automatically leave insert mode after 'updatetime' milliseconds of inaction
au CursorHoldI * stopinsert
"If you find that this event fires too quickly, you can adjust 'updatetime' to suit your needs, but you might want to consider doing so only when you enter insert mode:
"Yes this works in nvim too, I changed the time to 5 seconds DK
" set 'updatetime' to 15 seconds when in insert mode
au InsertEnter * let updaterestore=&updatetime | set updatetime=3000
au InsertLeave * let &updatetime=updaterestore
"
endif
