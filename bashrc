# Archlinux Ultimate Install - .bashrc
# by helmuthdu
# check for interactive
[[ $- = *i* ]] || return
## PS1 CONFIG
TXTGRN='\[\e[0;32m\]' # Green
TXTRST='\[\e[0m\]'    # Text Reset
TXTCYN='\[\e[0;36m\]' # Cyan
TXTPUR='\[\e[0;35m\]' # Purple
TXTYLW='\[\e[0;33m\]' # Yellow
TXTRED='\[\e[0;31m\]' # Red
TXTLRD='\[\e[1;31m\]' # Light-Red

if [[ `id -un` != root ]]; then
	PS1="\n\[\033[0;33m\]\u@\h \[\033[1;33m\] \w\n\[\033[0m\]=> "
else
	# Red & blue - root account prompt, with green entered text:
    PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\]'
    #PS1='\[\e[0;36m\]\t`if [ $? = 0 ]; then echo "\[\e[0;32m\] ✔ "; else echo "\[\e[0;31m\] ✘ "; fi`\[\e[0;31m\]\u\[\e[0;34m\] @\[\e[0;35m\]\h \[\e[0;33m\]\w \[\e[0;34m\]$\[\e[0m\] '
    #PS1="[${RD}\u@\h${BL} \W${GR}\$(parse_git_branch)\$(git_dirty_flag)${NONE}]# "
fi

# colour coreutils
eval $(dircolors -b ~/.dircolors_256)

## BASH OPTIONS {{{
  shopt -s cdspell                 # Correct cd typos
  shopt -s checkwinsize            # Update windows size on command
  shopt -s histappend              # Append History instead of overwriting file

# share history across all terminals
PROMPT_COMMAND="history -a; history -c; history -r"
  shopt -s cmdhist                 # Bash attempts to save all lines of a multiple-line command in the same history entry
  shopt -s extglob                 # Extended pattern
  shopt -s no_empty_cmd_completion # No empty completion

## COMPLETION
    complete -cf sudo
    if [[ -f /etc/bash_completion ]]; then
      . /etc/bash_completion
    fi


## EXPORTS
  export PATH=/usr/local/bin:/usr/lib/surfraw:$HOME/bin:$HOME/.scripts:/home/dka/.scripts/dzen:/usr/lib/ruby/gems/2.2.0:/home/dka/.gem/ruby/2.3.0/bin:/home/dka/.gem/ruby/2.2.0/bin:$PATH
  export GEM_PATH=/usr/lib/ruby/gems/2.2.0
  
if [ -d "$HOME/mygits/kodi-playercorefactory/bash-scripts" ] ; then
        PATH="$HOME/mygits/kodi-playercorefactory/bash-scripts:$PATH"
fi
#----------
#  if which google-chrome-beta &>/dev/null; then
#    export CHROME_BIN=/usr/bin/google-chrome-beta
# fi
#----
## EDITOR #{{{
    if which nvim &>/dev/null; then
      export EDITOR="nvim"
    elif which emacs &>/dev/null; then
      export EDITOR="emacs -nw"
    else
      export EDITOR="nano"
    fi

# export EDITOR='/home/dka/bin/default-editors.sh'
export BROWSER="chromium"
export NOTES_DIR="/media/ElementsA/Dropbox/Dropbox/notes"

  #}}}
  ## BASH HISTORY #{{{
    # make multiple shells share the same history file
    export HISTSIZE=500            # bash history will save N commands
    export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
    export HISTCONTROL=ignoreboth   # ingore duplicates and spaces
    export HISTIGNORE='&:ls:ll:la:cd:exit:clear:history'

#}}}
## ALIAS {{{
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi
# Functions: check for a separate function file, and if we find one
# source it.
if [[ -f ~/.bash_functions ]]; then
    . ~/.bash_functions
fi 
#source the z navigation plugin
. ~/z.sh

  
  # GIT_OR_HUB {{{
    if which hub &>/dev/null; then
      alias git=hub
    fi
  #}}}
  # AUTOCOLOR {{{
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  #}}}
  # MODIFIED COMMANDS {{{
    alias ..='cd ..'
    alias df='df -h'
    alias diff='colordiff'              # requires colordiff package
    alias du='du -c -h'
    alias free='free -m'                # show sizes in MB
    alias grep='grep --color=auto'
    alias grep='grep --color=tty -d skip'
    alias mkdir='mkdir -p -v'
    alias more='less'
    alias nano='nano -w'
    alias ping='ping -c 5'
  #}}}
  # PRIVILEGED ACCESS {{{
    if ! $_isroot; then
      alias sudo='sudo '
      alias scat='sudo cat'
      alias svim='sudo vim'
      alias root='sudo su'
      alias reboot='sudo reboot'
      alias halt='sudo halt'
    fi
  #}}}
  # PACMAN ALIASES {{{
    # we're on ARCH
    if $_isarch; then
      # we're not root
      if ! $_isroot; then
        alias pacman='sudo pacman'
      fi
      alias pacupg='pacman -Syu'            # Synchronize with repositories and then upgrade packages that are out of date on the local system.
      alias pacupd='pacman -Sy'             # Refresh of all package lists after updating /etc/pacman.d/mirrorlist
      alias pacin='pacman -S'               # Install specific package(s) from the repositories
      alias pacinu='pacman -U'              # Install specific local package(s)
      alias pacre='pacman -R'               # Remove the specified package(s), retaining its configuration(s) and required dependencies
      alias pacun='pacman -Rcsn'            # Remove the specified package(s), its configuration(s) and unneeded dependencies
      alias pacinfo='pacman -Si'            # Display information about a given package in the repositories
      alias pacse='pacman -Ss'              # Search for package(s) in the repositories

      alias pacupa='pacman -Sy && sudo abs' # Update and refresh the local package and ABS databases against repositories
      alias pacind='pacman -S --asdeps'     # Install given package(s) as dependencies of another package
      alias pacclean="pacman -Sc"           # Delete all not currently installed package files
      alias pacmake="makepkg -fcsi"         # Make package from PKGBUILD file in current directory
    fi

  #}}}
  # LS {{{
    alias ls='ls -hF --color=auto'
    alias lr='ls -R'                    # recursive ls
    alias ll='ls -alh'
    alias la='ll -A'
    alias lm='la | less'
    # Alias definitions.

  #}}}
#}}}
## FUNCTIONS {{{
  # BETTER GIT COMMANDS {{{
    bit() {
      # By helmuthdu
      usage(){
        echo "Usage: $0 [options]"
        echo "  --init                                              # Autoconfigure git options"
        echo "  a, [add] <files> [--all]                            # Add git files"
        echo "  c, [commit] <text> [--undo]                         # Add git files"
        echo "  C, [cherry-pick] <number> <url> [branch]            # Cherry-pick commit"
        echo "  b, [branch] feature|hotfix|<name>                   # Add/Change Branch"
        echo "  d, [delete] <branch>                                # Delete Branch"
        echo "  l, [log]                                            # Display Log"
        echo "  m, [merge] feature|hotfix|<name> <commit>|<version> # Merge branches"
        echo "  p, [push] <branch>                                  # Push files"
        echo "  P, [pull] <branch> [--foce]                         # Pull files"
        echo "  r, [release]                                        # Merge unstable branch on master"
        return 1
      }
      case $1 in
        --init)
          local NAME=`git config --global user.name`
          local EMAIL=`git config --global user.email`
          local USER=`git config --global github.user`
          local EDITOR=`git config --global core.editor`

          [[ -z $NAME ]] && read -p "Nome: " NAME
          [[ -z $EMAIL ]] && read -p "Email: " EMAIL
          [[ -z $USER ]] && read -p "Username: " USER
          [[ -z $EDITOR ]] && read -p "Editor: " EDITOR

          git config --global user.name $NAME
          git config --global user.email $EMAIL
          git config --global github.user $USER
          git config --global color.ui true
          git config --global color.status auto
          git config --global color.branch auto
          git config --global color.diff auto
          git config --global diff.color true
          git config --global core.filemode true
          git config --global push.default matching
          git config --global core.editor $EDITOR
          git config --global format.signoff true
          git config --global alias.reset 'reset --soft HEAD^'
          git config --global alias.graph 'log --graph --oneline --decorate'
          if which meld &>/dev/null; then
            git config --global diff.guitool meld
            git config --global merge.tool meld
          elif which kdiff3 &>/dev/null; then
            git config --global diff.guitool kdiff3
            git config --global merge.tool kdiff3
          fi
          git config --global --list
          ;;
        a | add)
          if [[ $2 == --all ]]; then
            git add -A
          else
            git add $2
          fi
          ;;
        b | branch )
          check_branch=`git branch | grep $2`
          case $2 in
            feature)
              check_unstable_branch=`git branch | grep unstable`
              if [[ -z $check_unstable_branch ]]; then
                echo "creating unstable branch..."
                git branch unstable
                git push origin unstable
              fi
              git checkout -b feature --track origin/unstable
              ;;
            hotfix)
              git checkout -b hotfix master
              ;;
            master)
              git checkout master
              ;;
            *)
              check_branch=`git branch | grep $2`
              if [[ -z $check_unstable_branch ]]; then
                echo "creating $2 branch..."
                git branch $2
                git push origin $2
              fi
              git checkout $2
              ;;
          esac
          ;;
        c | commit )
          if [[ $2 == --undo ]]; then
            git reset --soft HEAD^
          else
            git commit -am "$2"
          fi
          ;;
        C | cherry-pick )
          git checkout -b patch master
          git pull $2 $3
          git checkout master
          git cherry-pick $1
          git log
          git branch -D patch
          ;;
        d | delete)
          check_branch=`git branch | grep $2`
          if [[ -z $check_branch ]]; then
            echo "No branch founded."
          else
            git branch -D $2
            git push origin --delete $2
          fi
          ;;
        l | log )
          git log --graph --oneline --decorate
          ;;
        m | merge )
          check_branch=`git branch | grep $2`
          case $2 in
            --fix)
              git mergetool
              ;;
            feature)
              if [[ -n $check_branch ]]; then
                git checkout unstable
                git difftool -g -d unstable..feature
                git merge --no-ff feature
                git branch -d feature
                git commit -am "${3}"
              else
                echo "No unstable branch founded."
              fi
              ;;
            hotfix)
              if [[ -n $check_branch ]]; then
                # get upstream branch
                git checkout -b unstable origin
                git merge --no-ff hotfix
                git commit -am "hotfix: v${3}"
                # get master branch
                git checkout -b master origin
                git merge hotfix
                git commit -am "Hotfix: v${3}"
                git branch -d hotfix
                git tag -a $3 -m "Release: v${3}"
                git push --tags
              else
                echo "No hotfix branch founded."
              fi
              ;;
            *)
              if [[ -n $check_branch ]]; then
                git checkout -b master origin
                git difftool -g -d master..$2
                git merge --no-ff $2
                git branch -d $2
                git commit -am "${3}"
              else
                echo "No unstable branch founded."
              fi
              ;;
          esac
          ;;
        p | push )
          git push origin $2
          ;;
        P | pull )
          if [[ $2 == --force ]]; then
            git fetch --all
            git reset --hard origin/master
          else
            git pull origin $2
          fi
          ;;
        r | release )
          git checkout origin/master
          git merge --no-ff origin/unstable
          git branch -d unstable
          git tag -a $2 -m "Release: v${2}"
          git push --tags
          ;;
        *)
          usage
      esac
    }
  #}}}
  # TOP 10 COMMANDS {{{
    # copyright 2007 - 2010 Christopher Bratusek
    top10() { history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head; }
  #}}}

  # CONVERT TO ISO {{{
    to_iso () {
      if [[ $# == 0 || $1 == "--help" || $1 == "-h" ]]; then
        echo -e "Converts raw, bin, cue, ccd, img, mdf, nrg cd/dvd image files to ISO image file.\nUsage: to_iso file1 file2..."
      fi
      for i in $*; do
        if [[ ! -f "$i" ]]; then
          echo "'$i' is not a valid file; jumping it"
        else
          echo -n "converting $i..."
          OUT=`echo $i | cut -d '.' -f 1`
          case $i in
                *.raw ) bchunk -v $i $OUT.iso;; #raw=bin #*.cue #*.bin
          *.bin|*.cue ) bin2iso $i $OUT.iso;;
          *.ccd|*.img ) ccd2iso $i $OUT.iso;; #Clone CD images
                *.mdf ) mdf2iso $i $OUT.iso;; #Alcohol images
                *.nrg ) nrg2iso $i $OUT.iso;; #nero images
                    * ) echo "to_iso don't know de extension of '$i'";;
          esac
          if [[ $? != 0 ]]; then
            echo -e "${R}ERROR!${W}"
          else
            echo -e "${G}done!${W}"
          fi
        fi
      done
    }

    ## FIND AND REMOVED EMPTY DIRECTORIES {{{
      fared() {
        read -p "Delete all empty folders recursively [y/N]: " OPT
        [[ $OPT == y ]] && find . -type d -empty -exec rm -fr {} \; &> /dev/null
      }
    #}}}

  # ENTER AND LIST DIRECTORY{{{
    function cd() { builtin cd -- "$@" && { [ "$PS1" = "" ] || ls -hrt --color; }; }
  #}}}
  # SYSTEMD SUPPORT {{{
    if which systemctl &>/dev/null; then
      start() {
        sudo systemctl start $1.service
      }
      restart() {
        sudo systemctl restart $1.service
      }
      stop() {
        sudo systemctl stop $1.service
      }
      enable() {
        sudo systemctl enable $1.service
      }
      status() {
        sudo systemctl status $1.service
      }
      disable() {
        sudo systemctl disable $1.service
      }
    fi
  #}}}
#}}}
## For Sopcast ####################################
# gotbletu vid https://www.youtube.com/watch?v=Dm7cFjhzgHo
#Add to .bashrc
# install sopcast commandline version
# Archlinux: sopcast ( x64 https://www.archlinux.org/packages/multilib/x86_64/sopcast/)
# Archlinux: sopcast ( x32 https://www.archlinux.org/packages/community/i686/sopcast/)
# Ubuntu/Debian: sp-auth (https://launchpad.net/~jason-scheunemann/+archive/ppa)

# choose a players (cvlc is default)
SP_VIDPLAYER=cvlc
#SP_VIDPLAYER=vlc
# SP_VIDPLAYER=(vlc --control=lirc)
# SP_VIDPLAYER=mplayer
# SP_VIDPLAYER=(mplayer -cache 1000)

# wait X seconds to stabilize channel (make it longer if u got slower connection)
SP_SLEEP=15

# sopcast port and player port
SP_LOCAL_PORT=55050
SP_PLAYER_PORT=55051

# manually kill sopcast (sometimes it doesnt exit properly and still uses bandwidth in the background)
sppc-kill() { killall sp-sc ;}

# kills existing connection, starts a new connection, sleep X sec to stabilize the stream, waits to player to exit and kill itself
sppc() {
killall sp-sc &>/dev/null
(sp-sc "$1" $SP_LOCAL_PORT $SP_PLAYER_PORT &>/dev/null &)
sleep $SP_SLEEP
($SP_VIDPLAYER http://localhost:$SP_PLAYER_PORT)
wait
killall sp-sc
}


#### eng = english, ro = romanian, esp = espanol/spanish
# added on February 06, 2014
spp-doc-explorer.eng,ro() { sppc "sop://broker.sopcast.com:3912/149269" ;}
spp-doc-history.eng,ro() { sppc "sop://broker.sopcast.com:3912/148253" ;}
spp-doc-history2.eng,ro() { sppc "sop://broker.sopcast.com:3912/149268" ;}
spp-doc-natgeo.eng,ro() { sppc "sop://broker.sopcast.com:3912/148248" ;}
spp-doc-natgeowild.eng,ro() { sppc "sop://broker.sopcast.com:3912/148259" ;}
spp-doc-nature.eng,ro() { sppc "sop://broker.sopcast.com:3912/149267" ;}
spp-movie-hbo.eng,ro() { sppc "sop://broker.sopcast.com:3912/148883" ;}
spp-movie-hbo2.eng,ro() { sppc "sop://broker.sopcast.com:3912/120702" ;}
spp-tv-universal.eng,ro() { sppc "sop://broker.sopcast.com:3912/148255" ;}
spp-tv-axn.eng,ro() { sppc "sop://broker.sopcast.com:3912/148257" ;}
spp-tv-axncrime.eng,ro() { sppc "sop://broker.sopcast.com:3912/149261" ;}

#######################################################
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

. /home/dka/.jrc
alias goto=". goto"
