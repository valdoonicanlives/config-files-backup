#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
#to startx without a login manager
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx



#if [ -d "$HOME/bin" ] ; then
#    PATH="$HOME/bin:$PATH"
#fi

#. "$HOME/.bashrc"

#[[ -z $DISPLAY && $TERM = "linux" ]] && exec /home/dka/bin/archlogin
export PATH=$PATH:~/bin/
alias goto=". goto"
