"My Colours DK
"""""""""""""""""""""
set background=dark  " Use colors that are easier for dark backgrounds
:highlight Normal guibg=#363131 guifg=White
hi StatusLine      gui=none       guibg=#FFCC66  guifg=#000000
hi StatusLineNC    gui=none       guibg=#444444  guifg=#000000
""" Cursor """""""""
"hi Cursor       gui=NONE guifg=#ffffff guibg=#d86020
"hi lCursor      gui=NONE guifg=#ffffff guibg=#e000b0
"hi CursorIM     gui=NONE guifg=#ffffff guibg=#AAFF00
"hi iCursor      gui=NONE guifg=#ffffff guibg=#AAFF00


""""""""""""""""""
"For popups like the background color of FuzzyFinder
hi PMenu guifg=#dddddd guibg=#423d35 guisp=#423d35 gui=NONE ctermfg=253 ctermbg=238 cterm=NONE
hi PMenuSbar guifg=NONE guibg=#848688 guisp=#848688 gui=NONE ctermfg=NONE ctermbg=102 cterm=NONE
hi PMenuSel guifg=#ffd700 guibg=#706070 guisp=#706070 gui=bold ctermfg=220 ctermbg=242 cterm=bold
hi PMenuThumb guifg=NONE guibg=#a4a5a8 guisp=#a4a5a8 gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
""""""""""""""""""
"line numbering
hi LineNr ctermfg=Yellow ctermbg=Blue guifg=#B0AEAE guibg=black 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Found the below two lines on another site and they work as well as all the other lines did
"I added the last entry on each line guifg= It was working fine with white background in normal mode but if I chose black
"bachground colour with white text then the text was hardly to be seen in insert mode so stating the text color (which is guifg) is needed and then back to white text on leaving.
:au InsertEnter * hi Normal term=NONE    ctermbg=black guibg=#360707 guifg=white"
":au InsertEnter * hi Normal term=NONE    ctermbg=black guibg=#114982 guifg=white"
:au InsertLeave * hi Normal term=NONE    ctermbg=black    guibg=#212121 guifg=white" 

