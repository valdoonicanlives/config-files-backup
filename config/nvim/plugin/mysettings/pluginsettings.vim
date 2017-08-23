" =============================================================================
" PLUGIN SETTINGS SECTION
" =============================================================================
"NERDTree
nnoremap <leader>ntr :NERDTreeToggle<CR>
" move nerdtree to the right
let g:NERDTreeWinPos = "right"
" " move to the first buffer
"autocmd VimEnter * wincmd p
"==========
"For Mundo  (its like gundo for vim)
" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=/home/dka/.config/nvim/undofolder
nnoremap <leader>1 :MundoToggle<CR>
"===============
" ==CtrlP ========
let g:ctrlp_use_caching = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" make it skip files inside .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"use ag
"let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

"commented out below as it searches everything for text within it and I find it unusable DK
" To use with ripgrep
"if executable('rg')
""  set grepprg=rg\ --color=never
""  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
""  let g:ctrlp_use_caching = 0
""endif

"=======fzf settings=========
""if has('nvim')
""  let $FZF_DEFAULT_OPTS .= ' --inline-info'
 " " let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
"endif
"
""if executable('fzf')
""nnoremap <silent> <Leader><Leader> :FZF <CR>
""nnoremap <silent> <Leader>f :FZF /home/dka/text-files-home/<CR>
""nnoremap <leader>o :Files<cr>
""endif

"To use with neomru plugin
""nnoremap <silent> <Leader>m :call fzf#run({
""\   'source': 'sed "1d" $HOME/.cache/neomru/file',
""\   'sink': 'e '
""\ })<CR>
"===========================
" for highlighted yank colour
hi HighlightedyankRegion cterm=reverse gui=reverse
"
"Vim-Airline plugin settings
set laststatus=2
let g:airline_powerline_fonts=0
"Below line to list open buffers across the top
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='badwolf'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_linecolumn_prefix = '¶ '
"let g:airline_enable_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_section_x=""
let g:airline_section_y="%{strlen(&ft)?&ft:'none'}"
" -----------------------------------------------------

" ----------------------


"Vimwiki settings
" vimwiki with markdown support, line below what gotbletu uses
"let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" I just added 2 lines to the below to get markdown \ 'syntax': 'markdown', and \ 'ext': '.md', then when I ran it again it created a new index.md file instead of the index.wiki it was using
let g:vimwiki_list = [{
  \ 'path': '/home/dka/.config/vimwiki',
  \ 'template_path': '/home/dka/.config/vimwiki/templates',
  \ 'template_default': 'default',
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ 'template_ext': '.html'}]
  "Extras I have added lately DK
  "- automatically resolve folder links as folder/index.wiki
  let g:vimwiki_dir_link = 'index' 
  let g:vimwiki_folding='expr'
  nmap <Leader>wk <Plug>VimwikiIndex
"=================
" for extra instand markdown plugin
let g:instant_markdown_autostart = 0
" below keybinding to get a previiew in your browser, rather than the annoying autostart, type \md
map <leader>md :InstantMarkdownPreview<CR>
"==============="
"for vim-notes
let g:notes_directories = ['/home/dka/text-files-home', '/media/ElementsA/Dropbox/Dropbox/notes']
" ====================================================================================
