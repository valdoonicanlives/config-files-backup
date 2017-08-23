#My alaises

alias up='cd ..'
#alias up2='cd ../../'
alias ls='ls -F --color=auto --group-directories-first'
#alias ls='ls -a'
alias lt='ls -ltr'        # sort by date
# Only show directories
alias lsd='command ls -d *(/)'
#to use below you type list cakes to show all files in the dir containing the string cakes
alias list='ls | grep -i'
######################################
#from the .zshrc file made by grml
# Only show dot-directories
alias lad='command ls -d .*(/)'
# Only show dot-files
alias lsa='command ls -a .*(.)'
# Only show symlinks
alias lsl='command ls -l *(@)'
# Display only executables
alias lsx='command ls -l *(*)'
# Display the ten biggest files
alias lsbig="command ls -flh *(.OL[1,10])"
#a2# Display the ten newest files
alias lsnew="command ls -rtlh *(D.om[1,10])"
#a2# Display the ten oldest files
alias lsold="command ls -rtlh *(D.Om[1,10])"
#a2# Display the ten smallest files
alias lssmall="command ls -Srl *(.oL[1,10])"
#a2# Display the ten newest directories and ten newest .directories
alias lsnewdir="command ls -rthdl *(/om[1,10]) .*(D/om[1,10])"
#a2# Display the ten oldest directories and ten oldest .directories
alias lsolddir="command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])"
#############################
#SYSTEM
alias pacu="sudo packman -Syu"
alias paci="sudo packman -S"
alias showfreespace="df -h "
#We can find files in our current directory
alias finshere="find . -name "
alias sudo='sudo '   #this makes it so that you alias's are still used when in sudo
alias show-modified-today="ls *(m0) "
#below 2 lines work with the functions set in .zsh_functions
alias sounddefault="pa-set 0"
alias soundusb="pa-set 1"
#this one for conky and estonta callender script
alias 30estonta='estonta -r "now" "+30days"'
alias 60estonta='estonta -r "now" "+60days"'
#globl alias's
alias -g NF='*(.om[1])' # newest file
#alias d='dirs -v | head -10'
#list only dirs not files by typing onlyd
alias onlyd='find -maxdepth 1 -type d'
alias makex="chmod a+x"
alias ytview="youtube-viewer -C"
alias suplemon='cd /home/dka/mygits/suplemon ; python3 suplemon.py'
alias tvim='nvr --remote-silent'
alias nvim='NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim'
alias vim='nvim'
alias svim="sudo vim" # Run vim as super user
alias ac='echo "type-pass" ;/usr/bin/nvim ~/pfolder/p.cpt'
alias imagemanager='run-geeqie'
# TMUX
#alias ta='tmux attach'
alias ta='tmux att -t dka-tmux'
alias tnew="tmux new-session -s 'dka-tmux'"
alias tkill='tmux kill-session -t dka-tmux'
#alias emc="emacsclient -n" # no blocking terminal waiting for edit
# running emacs in terminal wasnt working untill I put in .zprofile
# export ALTERNATE_EDITOR=""
alias emacs='emacs -nw'
alias temacs='emacsclient -nw -t'
#alias temacs='emacsclient -nw -c -a ""'
alias gemacs='emacsclient -c'
alias searchnotes='cd ~/text-files && fe'
alias xe='eval `slmenu < slmenu-progs`'
#alias sxiv-all=sxiv ./*
#alias bigtext=printf ''\e]710;%s\007' "xft:DejaVu Sans Mono:pixelsize=18"'
#alias normaltext=printf ''\e]710;%s\007' "xft:DejaVu Sans Mono:pixelsize=14"'
alias showalias='cat /home/dka/.zsh/aliases.zsh'
alias @edit='edit-configs-and-scripts'
alias Edit='gvim'
alias edit='urxvt -e nvim'
#------- Edit config files
cfg-bashrc() { $EDITOR ~/.bashrc ;}
cfg-zsh_alias() { $EDITOR /home/dka/.zsh/aliases.zsh ;}
cfg-zsh_functions() { $EDITOR ~/.zsh_functions ;}
cfg-bashfunctions() { $EDITOR ~/.bash_functions ;}
cfg-keybindings() { $EDITOR ~/.config/sxhkd/sxhkdrc ;}
cfg-vimrc() { $EDITOR ~/.vim/vimrc ;}
cfg-hostsallow() { sudo $EDITOR /etc/hosts.allow ;}
cfg-hostdeny() { sudo $EDITOR /etc/hosts.deny ;}
cfg-fstab() { sudo $EDITOR /etc/fstab ;}
cfg-pacman() { sudo $EDITOR /etc/pacman.conf ;}
cfg-tmuxrc() { $EDITOR ~/.tmux.conf ;}
cfg-zshrc() { $EDITOR ~/.zshrc ;}
cfg-i3wm() { $EDITOR ~/.i3/config ;}
cfg-muttrc() { $EDITOR ~/.muttrc ;}
cfg-ranger() { $EDITOR ~/.config/ranger/rc.conf ;}
cfg-ranger-rifle() { $EDITOR ~/.config/ranger/rifle.conf ;}
cfg-tmuxrc() { $EDITOR ~/.tmux.conf ;}
cfg-qutebrowser() { $EDITOR ~/.config/qutebrowser/qutebrowser.conf ;}
cfg-qutebrowser-keys() { $EDITOR ~/.config/qutebrowser/keys.conf ;}
cfg-qutebrowser-quickmarks() { $EDITOR ~/.config/qutebrowser/quickmarks ;}
# edit single line snippet
cfg-snippetrc() { $EDITOR ~/.snippetrc ;}
# edit multiline snippet
cfg-multisnippetrc() { $EDITOR ~/.multisnippet/"$(ls ~/.multisnippet | fzf -e -i)" ;}
#create new multiline snippet
multisnippet() { $EDITOR ~/.multisnippet/"$1" ;}
#-------- Configurations Reload
rld-zsh-alias() { source ~/.zsh_alias ;}
rld-xdefaults() { xrdb ~/.Xdefaults ;}
rld-xmodmap() { xmodmap ~/.Xmodmap ;}
rld-xresources() { xrdb -load ~/.Xresources ;}
rld-zshrc() { source ~/.zshrc ;}
alias catp='ccrypt -c --key kered00 /home/dka/p.cpt'
alias editp='ccrypt --decrypt --key kered00 /home/dka/p.cpt ;vim /home/dka/p'
alias encryptp='ccrypt --encrypt --key kered00 /home/dka/p'
# cli pastebin client
alias pastebinit='pastebinit -a "elwoode" -b "http://paste2.org" -t "elwoode was here"'
# copy/paste for linux machines (Mac style)
alias pbcopy='xclip -selection clipboard'	# copy to clipboard, ctrl+c, ctrl+shift+c
alias pbpaste='xclip -selection clipboard -o'	# paste from clipboard, ctrl+v, ctrl+shitt+v
alias pbselect='xclip -selection primary -o'	# paste from highlight, middle click, shift+insert
alias pbdump='pbpaste | pastebinit | pbcopy'	# dump text to pastebin server
#eject cd
alias ejectcd='eject /dev/sr0'
alias opencd='eject /dev/sr0'
alias stopmpd='mpd --kill'
#alias muttad="mutt -F ~/.mutt/adent.rc"
#alias mutt="mutt -F ~/.mutt/delwoode.rc"
alias mountold-home='sudo mount /dev/sda9 /mnt/oldarch'
alias mountold-root='sudo mount /dev/sda8 /mnt/oldroot'
alias mount-windows='sudo mount /dev/sda1 /mnt/windows'
#show url-bookmarks
alias showurls='cat .urlbms'
#type gs dogs to search google for dogs
alias gs='sr google'
alias freemem='sudo /sbin/sysctl -w vm.drop_caches=3'
alias screencast='/home/dka/bin/ffcast' #records full screen
alias yogurt="yaourt"
alias jogurt="yaourt"
# pacman alias's in separate file now
#alias pacu='sudo pacman -Syu'
#alias paci='sudo pacman -S'
#alias pacr='sudo pacman -Rnsvc'
#alias pacs='pacman -Ss'  search for packages
alias calc='python -ic "from __future__ import division; from math import *; from random import *"'
#
alias x="exit"
alias hot=sensors
alias editbashrc='vim ~/.bashrc'
alias reloadalias='source /home/dka/.zim/modules/custom/init.zsh'
## vim alias's to open encrypted files in vim-terminal - you are asked for pass (same as old pass k----00 for admin on arch)
alias open-temple=open-temple.sh
alias unmounttemple='fusermount -u  /media/ElementsA/templemount'
alias mountpfolder='encfs ~/.pfolder ~/pfolder'
alias unmountpfolder='fusermount -u ~/pfolder'
#for translate script
alias tr='translate'
alias trnl='translate {=nl}'
alias tres='translate {=es}'
alias funnysymbols='leafpad /media/WDa/Dropbox/text-files/funnysymbols.txt'
alias ri='vim /media/WDa/Dropbox/text-files/linux/recently-installed.txt'
alias screenshot='/home/dka/bin/screenshot-scripts/myscreenshot.sh'
# have function for this now - alias qn='xfw ~/text-files/qnotes.txt'
alias today='date +"%A, %B %-d, %Y"'	#Date and time
alias vimEN='vim -u ~/.vimencrypt -x'
alias downloads='cd ~/Downloads'
alias home="cd ~/"
alias music="cd ~/music"
alias create=touch
alias yd=youtube-dl
alias ydmp3='youtube-dl -t -x --audio-format mp3 --audio-quality 0'
alias explorer=spacefm
alias makedir=mkdir
alias copy=cp
alias rem='rm -i'
alias remdir='rmdir -i'
alias rm='rm -i'
alias mv='mv -i'
#below to untar a .tar file
alias untar='tar -vxf'
#alias dropbox='dropbox start'
alias music='pragha'
alias al='cat ~/.bash_aliases'
alias editbash_functions='vim ~/.bash_functions'
alias editxinitrc='vim ~/.xinitrc'
alias editalias='vim ~/.zsh_alias'
#alias qn='nano -e ~/text-files/qnotes.txt'
alias mytodo='nano -e ~/text-files/todo.txt'
#alias recently-installed='gedit /home/dk/Dropbox/notes/deft-org-notes/recently-installed.org &'
alias mynotes='geany /home/dka/Dropbox/docs/mynotes.txt &'
alias future='vim -e /media/ElementsA/Dropbox/notes/future'
alias radio=~/.pyradio/pyradio.py
alias muzak='pragha'
alias recent='find -maxdepth 1 -type f -mtime -1 -printf "%T@-%Tk:%TM - %f\n" | sort -rn | cut -d- -f2-'
##Surfraw alais's
# to use below type cbs YOUR SEARCH TERM; doesn't work maybe would work in bash
#alias cbs="surfraw -g google site:crunchbang.org/forums"
## Web-site alias ###
alias youtube='chromium www.youtube.com'
alias hotmail='chromium www.hotmail.co.uk && hm'
alias hm='hm'
alias cbhm='cbhm'
alias movies='chromium www.imdb.com'
alias watch='chromium http://veetle.com/index.php/listing'
alias delayhm='sleep 10 ;hm'
alias events7days='estonta -r "now" "+7days"'
alias events='estonta'
# zsh only alias's
alias -s txt=$EDITOR
alias -s {avi,flv,mkv,mp4,mpeg,mpg,ogv,wmv}=$PLAYER
alias -g NF='*(.om[1])' 		# newest file
