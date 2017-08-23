" Some keysettings to do with plugins are in the pluginsettings file
" KEY MAPPINGS
"MOST used and useful ones first
" F2 to show recent files list
nnoremap <F2> :MRU<CR>
imap <F2> <C-O><F2>
" When in insert mode, you can move the cursor by using CTRL+h, CRTL+j, CTRL+k or CTRL+l
" The C-h part is the only one that doesn't work in nvim
" try nnoremap <C-h> <C-w>h , so you press Ctr+h w
"Using the below one so far, dont often use C-h anyway
" or put this in your tmuxconf  bind-key -n C-h send-keys Escape "[104;5u"
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l
" Moving between buffers, already have a plugin that gives you [b and ]b and [t and ]t
nnoremap <C-PageDown> :bnext<cr>
nnoremap <C-PageUp>   :bprevious<cr>
" Easier to type, and I never use the default behavior
" H=goto begin of line
" L=goto end of line
noremap H ^
noremap L $

" Set leader key to space (caps lock) instead of default \
let mapleader="\<Space>"
let maplocalleader="\\"
" Unmap the arrow keys for insert and normal mode, left out visual mode so far, took out insert mode too as it allows you to mv around in insertmode
no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP
"ino <down> <Nop>
"ino <left> <Nop>
"ino <right> <Nop>
"ino <up> <Nop>
"Disable left arrow key to make me use jk
"noremap <Left> <NOP> 
" open current file in palemoon
nnoremap <F5> :silent update<Bar>silent !palemoon %:p:s?\(.\{-}/\)\{4}?http://localhost/?<CR>
" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
" test by me Dk, you type space al to format a paragraph 
nnoremap <leader>al  gwap
" Open notes
command! Notes :call OpenNotes()
"type :Notes or to add a keybinding you would add
"nnoremap <silent> ,r :Notes<CR>
" to call the ranger function
nnoremap ,r :call RangerChooser()<CR>

"call the html template function, commented out as hardly use such a thing
"nnoremap ,n :call HTMLT()<CR>
" Use tab to indent a line
vmap > >gv
vmap < <gv
" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr-
"makes searching work better
nnoremap / /\v
vnoremap / /\v   
"-------COPY & PASTE SECTION --------------
" copy to system clipboard
map gy "*y
" copy whole file to system clipboard
nmap gY gg"*yG
" Control-x r = show paste register and choose number
noremap <C-x>r :call Reg()<CR>
" Use xclip to paste
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
" groovyness in Insert mode (lets you paste and keep on typing)
imap <C-v> <Esc><C-v>a
" Select your just pasted text press gp
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
"---END of Copy Paste SECTION-------
"
" SEARCH & REPLACE
 " type gs then notice in the command line the cursor is in the right postion to type the word you want replacing then/otherword
nnoremap gs :%s//g<Left><Left>
"
"Toggle line n column highlighting
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
"Use this mapping as a convenient way to play a macro recorded to register a:
nnoremap <Leader>m @a
" From https://github.com/henrik/dotfiles/blob/master/vim/config/mappings.vim
" To View Google calender
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
"-------------------------My Keybindings ------------- {{{
" clear the command line and search highlighting
nnoremap <C-l> :nohlsearch<CR>
" surround current word with brackets by typeing \b
:nnoremap <leader>b viw<esc>a)<esc>hbi(<esc>lel
" Quickly close windows
nnoremap <leader>x :x<CR>
" Opens a file with the current working directory already filled in so you have to specify only the filename.
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

"New Tab by pressing Ctrl+t
nnoremap     <C-T> :tabnew<CR>
" Remap movement between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" yank to end of line and yank to beg of line
nnoremap y0 y$
nnoremap y9 y^
" same for delete
nnoremap d0 d$
nnoremap d9 d^

" Select all
nnoremap <C-a> ggVG$
"keybinding to change font size to smaller and another to change it back
nnoremap <F9> :set guifont=Monospace\ 10<CR>
nnoremap <S-F9> :set guifont=Monospace\ 11<CR>
"Control+f to explore text-files directory
nnoremap <C-f> :Explore /media/ElementsA/Dropbox/Dropbox/text-files/<CR>
nnoremap <leader>s :set spell!<cr>
"below is to scramble(encrypt the line you are on) you type EN then enter
nnoremap EN Hg?L
" Bind <F12> to rot13 - can try this for encryption also -yes works-to unencrypt type g?L
nmap <F12> Hg?L
imap <F12> <ESC>Hg?L
"press Control d  in insertmode will delete the line
:imap <c-d> <esc>ddi
"" Allows writing to files with root privledges """
cmap w!! %!sudo tee > /dev/null % 
" sudo write this file-same as above one so keep in case above doesn't work 
"cmap W! w !sudo tee % >/dev/null 
" Edit VIMRC now nvim init with keys \ev
"nnoremap <silent> <Leader>ev :tabnew<CR>:e $MYVIMRC<CR>
nnoremap <leader>ev :e  ~/.config/nvim/init.vim<CR>
" Reload Vimrc
noremap <silent> <leader>sv :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<cr>
"BUT if you edited the rc file within vim itself then you dont need the above as the below will autoreload it 
" Automatically source vimrc on save.
autocmd! bufwritepost $MYVIMRC source $MYVIMRC
nnoremap <silent> <Leader>todo :e ~/text-files-home/todo.txt<CR>
" change directory to the file being edited. The mapping below maps the keystrokes ,cd (comma c d) to do that
nnoremap ,cd :cd %:p:h<CR>
"""""""""""""""""""""""""""""
nmap <leader>notes :e  /home/dka/text-files-home/
nmap <leader>vuse :e /media/ElementsA/Dropbox/Dropbox/text-files/vim/usage.txt
nmap <leader>pw :e /media/ElementsA/Dropbox/Dropbox/notes/vim-encrypted/vimp
nmap <leader>journal :e /media/ElementsA/Dropbox/Dropbox/notes/vim-encrypted/journal
nmap <leader>vps :e /media/ElementsA/Dropbox/Dropbox/notes/vim-encrypted/vim-sp
nmap <leader>vimweb :e /media/ElementsA/Dropbox/Dropbox/notes/vim-encrypted/vim-websites-en
"""""""""""""""""""

""""""""""""""""""""""
" minibuffer command
"To map Ctrl-Tab and Ctrl-Shift-Tab to bring up the next or previous buffer
"-have commented it out as not using minibuff explorer now
"let g:miniBufExplMapCTabSwitchBufs = 1"	
" remapped keys ------------- -----------------------
nnoremap ; :
"Pressing F3 will save out a file if it already has a name
:nnoremap <F3> :w<CR>
inoremap jj <ESC>
"Navigate wrapped lines naturally
nnoremap j gj
nnoremap k gk
"{{{====ABREVIATIONS=======================================
"bash
ab bash #!/bin/bash
iabbr emhm elwoode@hotmail.co.uk
iabbr emgm delwoode@gmail.com
iabbr emarthur arthurdentgwm@gmail.com
iabbr emailsig •*¨*•.¸¸❤ Elwoode ❤¸¸.•*¨*•
"Fix common spelling mistakes
iab Taht That
iab taht that
iab Teh The
iab teh the
" abbreviation to manually enter a Date only stamp. Just type Tdate in insert mode 
iab Tdate <C-R>=strftime("%m/%d/%Y")<CR>
" This one puts the Date and Time
iab Dwtime <C-R>=strftime("%m/%d/%Y - %T")<CR>
"}}}
" "Uppercase word" mapping.
"
" This mapping allows you to press <ctrl-u> in insert mode to convert the current
" word to uppercase.  It's handy when you're writing names of constants and
" don't want to use Capslock.
"
" To use it you type the name of the constant in lowercase.  While your
" cursor is at the end of the word, press <c-u> to uppercase it, and then
" continue happily on your way:
"
"                            cursor
"                            v
"     max_connections_allowed|
"     <c-u>
"     MAX_CONNECTIONS_ALLOWED|
"                            ^
"                            cursor
"
" It works by exiting out of insert mode, recording the current cursor location
" in the z mark, using gUiw to uppercase inside the current word, moving back to
" the z mark, and entering insert mode again.
"
" Note that this will overwrite the contents of the z mark.  I never use it, but
" if you do you'll probably want to use another mark.
inoremap <C-u> <esc>mzgUiw`za

vnoremap u <nop>
vnoremap gu u
vnoremap K k

"Toggle relative line numbering on and off
nnoremap <silent><leader>nn :set relativenumber!<cr>
"toggle line numbering by pressing ctrl and l (twice)
:nmap <C-l><C-l> :set invnumber<CR>
"==========
"FUZZY FINDER  ()using Ctrl-p  now DK)
" limit number of displayed matches
" (makes response instant even on huge source trees)
"let g:fuf_enumeratingLimit = 50
"this command will search for files that are in the same dir as the file in current buffer
"nnoremap fc :FufFileWithCurrentBufferDir<CR>
"this command will search for files in other dirs too
"nnoremap ff :FufFile<CR>
" this is file browser mode - like nerdtree
":nnoremap <leader>fn :FufFile /media/ElementsA/Dropbox/Dropbox/notes/<CR>
":nnoremap <leader>ft :FufFile /media/ElementsA/Dropbox/Dropbox/text-files/<CR>
":nnoremap <leader>vim :FufFile /media/ElementsA/Dropbox/Dropbox/text-files/vim/<CR>
" Dirs and extensions to ignore
"let s:extension = '\.bak|\.dll|\.exe|\.o|\.pyc|\.pyo|\.swp|\.swo'
"let s:dirname = 'build|deploy|dist|vms|\.bzr|\.git|\.hg|\.svn|.+\.egg-info'
"let g:fuf_file_exclude = '\v\~$|\.(DS_Store|o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
"
" END of MY Keymapping ----------------------
