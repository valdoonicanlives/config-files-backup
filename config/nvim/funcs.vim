"------------------------------
"Display the numbered registers, press a key and paste it to the buffer so use :Reg or make a keybinding to it 
" I made Ctrl+x r  to call it

function! Reg()
    reg
    echo "Register: "
    let char = nr2char(getchar())
    if char != "\<Esc>"
        execute "normal! \"".char."p"
    endif
    redraw
endfunction

command! -nargs=0 Reg call Reg()
"-------------------------------------
" Simple notes management
function! OpenNotes() abort
  execute ':e /home/dka/text-files-home/vim-notes.md'
endfunction
"----------------------------------------
" Add ranger as a file chooser in vim Compatible with ranger 1.4.2 through 1.6.
"
" If you add this function and the key binding to the .vimrc, ranger can be
" started using the keybinding ",r".  Once you select a file by pressing
" enter, ranger will quit again and vim will open the selected file.
fun! RangerChooser()
    exec "silent !ranger-dk --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
"The keybinding is in my keymappings file-it's ,r
"-----------------
function! HTMLT()
    " path to the template file below
    r~/.vim/templates/skeletonhtml.txt
endfunction
"keybinding in separate file is ,n
"-------------------------------------
"open the url on the current line must be full addres with http: at the front, I changed it so that www at the front works too DK
" Evoke a web browser
function! Browser ()
  let line0 = getline (".")
  let line = matchstr (line0, "http[^ ]*")
  :if line==""
  let line = matchstr (line0, "www[^ ]*")
  :endif
  :if line==""
  let line = matchstr (line0, "file[^ ]*")
  :endif
  let line = escape (line, "#?&;|%")
  " echo line
  exec ":silent !google-chrome-beta ".line
endfunction
map <Leader>url :call Browser ()<CR>
"--------------------------------
function! DmenuOpen(cmd)
   let fname = Chomp(system("ls | dmenu -i -l 20 -p " . a:cmd))
 " let fname = Chomp(system("find | dmenu -i -l 20 -p " . a:cmd))  this also works but is slower and not as good DK
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

" use \ddt to open file in a new tab
" use \dde to open file in current buffer
map <leader>ddt :call DmenuOpen("tabe")<cr>
map <leader>dde :call DmenuOpen("e")<cr>
"---------------------------------
" Copy and paste function using xclip
"function! ClipboardYank() abort
"  call system('xclip -i -selection clipboard', @@)
"endfunction

"function! ClipboardPaste() abort
"" let @@ = system('xclip -o -selection clipboard')
""endfunction
"-----------------------------------------
" Profile neovim and save results to profile.log
function! Profile() abort
  execute 'profile start profile.log'
  execute 'profile func *'
  execute 'profile file *'
  echom 'Profiling started (will last until you quit neovim).'
endfunction

" When cycling ignore NERDTree and Tagbar
function! IntelligentCycling() abort
  " Cycle firstly
  wincmd w
  " Handle where you are now
  if &filetype ==# 'nerdtree'
    call IntelligentCycling()
  endif
  " If in terminal buffer start insert
  if &buftype ==# 'terminal'
    startinsert!
  endif
endfunction



" Run NERDTreeFind or Toggle based on current buffer
function! NerdWrapper() abort
  if &filetype ==# '' " Empty buffer
    :NERDTreeToggle
  elseif expand('%:t') =~? 'NERD_tree' " In NERD_tree buffer
    wincmd w
  else " Normal file buffer
    :NERDTreeFind
  endif
endfunction

" Strip trailing spaces
function! StripTrailingWhitespaces() abort
  " Preparation: save last search, and cursor position.
  let l:lastSearch = @/
  let l:line = line('.')
  let l:col = col('.')

  " Do the business:
  execute '%s/\s\+$//e'

  " Clean up: restore previous search history, and cursor position
  let @/ = l:lastSearch
  call cursor(l:line, l:col)
endfunction



" Tab wrapper
function! TabComplete() abort
  let l:col = col('.') - 1
  if !l:col || getline('.')[l:col - 1] !~# '\k'
    return "\<TAB>"
  else
    if pumvisible()
      return "\<C-n>"
    endif
  endif
endfunction

" Mode function for Lightline statusline
"function! LightLineMode() abort
"  let l:fname = expand('%:t')
"  return l:fname =~? 'NERD_tree' ? 'NT' :
"        \ &filetype ==? 'unite' ? 'Unite' :
"        \ winwidth(0) > 70 ? Lightline#mode() : ''
"endfunction

" File format function for Lightline statusline
"function! LightLineFileformat() abort
"  return winwidth(0) > 70 ? &fileformat : ''
"endfunction

" Filetype function for Lightline statusline
"function! LightLineFiletype() abort
"  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
"endfunction

" File encoding function for Lightline statusline
"function! LightLineFileencoding() abort
"  return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
"endfunction


