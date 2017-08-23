set shortmess+=I  "disable the welcome screen
set guioptions-=T  "remove toolbar
set guioptions+=a 
filetype plugin indent on
"below lets you switch between buffers without having to save files
set hidden
"the 2 lines below are for vimwiki plugin to work properly
filetype plugin on
syntax on
" Unix as standard file type
set ffs=unix,dos,mac
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" FOR PATHOGEN
execute pathogen#infect()
" =============================================================================
" Source my separate settings files
"actually putting them in the /home/dka/.config/nvim/plugin/  folder works they are automatically loaded there. Even within subfolders
"source /home/dka/.config/nvim/keyshortcutsandpluginsettings.vim
"source /home/dka/.config/nvim/autocmd.vim
"source /home/dka/.config/nvim/funcs.vim
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif
"=============================================================
set shell=/usr/bin/zsh
" Turn on spell checking to turn off temporarily whilst using vim just type  set nospell.
"set spell
" Reading/Writing
set autowriteall     " Don't bother me about changed buffers
set foldmethod=marker
"show words selected when you for instance press * when on a word and then n and p to go to next instance of that word.
set hls
"---------------------------
" terminal
tnoremap <F12> <C-\><C-n> 
set switchbuf+=useopen
function! TermEnter()
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, "term://") > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
        break
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches >= 1)
    execute ":sbuffer ". firstmatchingbufnr
    startinsert
  else
    execute ":terminal"
  endif
endfunction
map <F12> :call TermEnter()<CR>
"--------------------------
" Set IBeam shape in insert mode, underline shape in replace mode and block shape in normal mode.
" working in plain urxvt terminal but not in tmux
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
" Try these for tmux, nope didn'twork
"let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
"let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" }}}

"I wished they had an option that would handle the first line like they do the last, but I take what I can get.
set display=lastline
"-------------------------------------------

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10
set showmode       " If in Insert, Replace or Visual mode put a message on the last line
"---------
"set complete+=k    "enable dictionary completion

let MRU_Max_Entries=15
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
"below needed for lusty explorer to work
"show a buffers menu
set showcmd    " Show incomplete normal mode commands as I type.
"----------------

"Type \c to toggle highlighting of line and column you are on.
"The line below sets up custom colors but can just use default ones.
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234

"turn blinking off for normal and visual mode
set guicursor +=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
"set guicursor+=n-v-c:blinkon0
highlight Cursor guifg=#ffffff guibg=#d86020
highlight iCursor guifg=#ffffff guibg=#AAFF00

"below to set an end of line character
set listchars=tab:▸\ ,eol:¬
set showbreak=↪

"highlight line when over 80 characters
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
"for Supertab
"autocmd FileType html let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" backup settings ====================================
set backup                  " keep a backup file
set backupdir=~/.vim/backup " backup dir
set noswapfile
"""""""""" VIMRC """""""""""""""""
" au! BufWritePost .init.vim source %   " Reload init.vim  when we edit it in nvim and save it
"""""""""""""""""""""""""""""""""""
" Make backspace work as usual.
set backspace=indent,eol,start "
set history=40    "40 lines of command history
set cmdheight=2   "set the command height
set wildmenu
set wildmode=list:longest " wildmode works great this way
" ignore files vim doesnt use
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*

set sc       "Show commands as you type them
"    Parentheses completion"--¬
inoremap (       ()<Left>
inoremap <expr>  ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap [       []<Left>
"====================
" exit insert mode automatically when you haven't typed anything for a few seconds?
" set 'updatetime' to 9 seconds when in insert mode
" Have disabled it as just found it annoying
" au InsertEnter * let updaterestore=&updatetime | set updatetime=9000
" au InsertLeave * let &updatetime=updaterestore
" automatically leave insert mode after 'updatetime' milliseconds of inaction
" au CursorHoldI * stopinsert
"=======================================================
"Colorscheme-settings -------- {{{
"colorscheme DK-scheme 
"trying out new scheme below
"colorscheme cobalt
"Now trying out 256 colourscheme
"colorscheme 256-colourscheme
"Going to try out the below one now
colorscheme onebvim

"set background=dark  " This is set in the separate color scheme file now, Use colors that are easier for dark backgrounds
:highlight Normal guibg=#363131 guifg=White
hi StatusLine      gui=none       guibg=#FFCC66  guifg=#000000
hi StatusLineNC    gui=none       guibg=#444444  guifg=#000000
""" Cursor """""""""
"hi Cursor       gui=NONE guifg=#ffffff guibg=#d86020
"hi lCursor      gui=NONE guifg=#ffffff guibg=#e000b0
"hi CursorIM     gui=NONE guifg=#ffffff guibg=#AAFF00
"hi iCursor      gui=NONE guifg=#ffffff guibg=#AAFF00
" highlight the status bar when in insert mode so that will have a better visual clue when using vim in terminal
au InsertEnter * hi StatusLine ctermfg=240 ctermbg=12
au InsertLeave * hi StatusLine ctermbg=235 ctermfg=2

""""""""""""""""""
"For popups like the background color of FuzzyFinder
hi PMenu guifg=#dddddd guibg=#423d35 guisp=#423d35 gui=NONE ctermfg=253 ctermbg=238 cterm=NONE
hi PMenuSbar guifg=NONE guibg=#848688 guisp=#848688 gui=NONE ctermfg=NONE ctermbg=102 cterm=NONE
hi PMenuSel guifg=#ffd700 guibg=#706070 guisp=#706070 gui=bold ctermfg=220 ctermbg=242 cterm=bold
hi PMenuThumb guifg=NONE guibg=#a4a5a8 guisp=#a4a5a8 gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
""""""""""""""""""
"line numbering
hi LineNr ctermfg=grey ctermbg=black guifg=#B0AEAE guibg=black 
"Set relative number on starup but can toggle it with below keybinding
set relativenumber

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Found the below two lines on another site and they work as well as all the other lines did
"I added the last entry on each line guifg= It was working fine with white background in normal mode but if I chose black
"bachground colour with white text then the text was hardly to be seen in insert mode so stating the text color (which is guifg) is needed and then back to white text on leaving.

:au InsertEnter * hi Normal term=NONE    ctermbg=black     guifg=white"
:au InsertLeave * hi Normal term=NONE    ctermbg=black    guifg=white" 
" End of colour settings ------------------ }}}

"""""""""""""""""""""""""""""""""
" some new ones

set clipboard=unnamedplus  " use the clipboards of vim and win
""""""""""""""""""""""""""""""""""""""""""""
"put this in your vimrc
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction


"""""""""""""""""""""""""""""""""""""""""""
"CURSOR COLOUR When in terminal
" change the color of the cursor to white in command mode,and orange in insert mode
if &term =~ "xterm\\|URxvt"
  :silent !echo -ne "\033]12;white\007"
  let &t_SI = "\033]12;orange\007"
  let &t_EI = "\033]12;white\007"
  autocmd VimLeave * :!echo -ne "\033]12;white\007"
endif 

"CURSOR SHAPE
"	set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor "
"	set guicursor+=i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor "
"	set guicursor+=sm:block-Cursor,a:blinkwait750-blinkoff750-blinkon750 "
"""""""""""""""""""""""""""""
" wrap like other editors
set wrap                " word wrap
set textwidth=0         " 
set lbr                 " line break
set display=lastline    " don't display @ with long paragraphs
set number"
set numberwidth=3"

""""" statusline  """""""""""""""""""""""""""""
if has('statusline')
set laststatus=2"
" Format the status line
"statusline: filepath, filetype, mod, rw, help, preview,   
set statusline=%y\ %f\ %m%r%h%w
"statusline: separation between left and right aligned items
set statusline+=%=
endif
"Another one to try out
"	if has('statusline')
"        set laststatus=2
"
" Broken down into easily includeable segments
"        set statusline=%<%f\ " Filename
"        set statusline+=%w%h%m%r " Options
"        set statusline+=%{fugitive#statusline()} " Git Hotness
"        set statusline+=\ [%{&ff}/%Y] " Filetype
"        set statusline+=\ [%{getcwd()}] " Current dir
"        set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
"    endif
" ---------------------------
"So that the File, Open dialog defaults to the current file's directory. 
set browsedir=buffer
"show the tilda sign on empty lines
highlight EndOfBuffer ctermfg=white ctermbg=black

