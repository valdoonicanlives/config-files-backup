" Plugged: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" =============================================================================
" 1.0 Plugin manager (Plug) settings
" =============================================================================
"{{{

" Autoinstall {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}
call plug#begin('/home/dka/.config/nvim/plugged')

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"Plugin 'vim-scripts/vimwiki'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
"-------My plugin list DK
" ======= plugins from http://vim-scripts.org/vim/scripts.html
Plug 'L9'
Plug 'FuzzyFinder'
" ======== GitHub plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
" On-demand loading of plugins:
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Buffers tabline
"Plug 'ap/vim-buftabline'
"Plug 'bling/vim-airline' #trying Lightline now, supposed to be lighter
"  Lightline (simple status line)
Plug 'itchyny/lightline.vim'
Plug 'itchyny/calendar.vim'
Plug 'bling/vim-bufferline'
Plug 'terryma/vim-multiple-cursors'
Plug 'xolox/vim-notes'
"The above plugin requires the vim-misc plugin too
Plug 'xolox/vim-misc'
Plug 'vimwiki/vimwiki'
Plug 'machakann/vim-highlightedyank'
" Any valid git URL is allowed, eg
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" All of your Plugins must be added before the following line
call plug#end()
"
"
" Brief help
" :PluginList       - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" =============================================================================
" Plugin settings section
" =============================================================================
" ----------------------
" for highlightedyank colour
hi HighlightedyankRegion cterm=reverse gui=reverse
"Airline plugin settings
" Airline
"let g:airline_powerline_fonts=0
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='badwolf'
"#let g:airline_left_sep = ''
"#let g:airline_right_sep = ''
"let g:airline_linecolumn_prefix = '¶ '
"let g:airline_enable_prefix = '⎇ '
"let g:airline_paste_symbol = 'ρ'
"let g:airline_section_x=""
"let g:airline_section_y="%{strlen(&ft)?&ft:'none'}"
" -----------------------------------------------------
" 4.7 Lightline settings {{{
" -----------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'tab': {
      \   'active': [ 'filename' ],
      \   'inactive': [ 'filename' ]
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'filetype', 'fileencoding', 'fileformat' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"HELP":&readonly?"RO":""}'
      \ },
      \ 'component_function': {
      \   'mode': 'utils#lightLineMode',
      \   'filename': 'utils#lightLineFilename',
      \   'filetype': 'utils#lightLineFiletype',
      \   'fileformat': 'utils#lightLineFileformat',
      \   'fileencoding': 'utils#lightLineFileencoding'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&readonly)'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
"}}}

"Vimwiki settings
" vimwiki with markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{
  \ 'path': '/home/dka/.config/vimwiki',
  \ 'template_path': '/home/dka/.config/vimwiki/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}]

"for vim-notes
let g:notes_directories = ['/home/dka/text-files-home', '/media/ElementsA/Dropbox/Dropbox/notes']
