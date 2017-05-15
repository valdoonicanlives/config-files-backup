#  author  xero <x@xero.nu>
#  code    http://code.xero.nu/dotfiles
#  mirror  http://git.io/.files
#
# timestamps
#HIST_STAMPS=mm/dd/yyyy

#█ paths
#export PATH=$HOME/bin:/usr/local/bin:/home/dka/.scripts:/home/dka/mygits/kodi-playercorefactory/bash-scripts:/home/dka/.gem/ruby/2.2.0/bin:$PATH
#export MANPATH=/usr/local/man:$MANPATH

#export BROWSER="chromium" 
# preferred editor for local and remote sessions
#export EDITOR=nvim
export VISUAL=geany
# find alternative apps if it is installed on your system
find_alt() { for i;do which "$i" >/dev/null && { echo "$i"; return 0;};done;return 1; }

# set the default program
# the first program in the array that is detected on your system will be chosen as the default
export OPENER=$(find_alt xdg-open exo-open gnome-open )
export BROWSER=$(find_alt chromium chromium-browser qutebrowser google-chrome firefox $OPENER )
export BROWSERCLI=$(find_alt w3m links2 links lynx elinks $OPENER )
export EBOOKER=$(find_alt ebook-viewer $OPENER )
export EDITOR=$(find_alt nvim nano leafpad geany $OPENER )
export FILEMANAGER=$(find_alt pcmanfm thunar nautilus dolphin spacefm enlightenment_filemanager $OPENER )
export MUSICER=$(find_alt mplayer mpg123 mpv cvlc $OPENER )
export PAGER=$(find_alt less more most)
export PLAYER=$(find_alt mplayer mpv cvlc $OPENER )
export READER=$(find_alt mupdf zathura evince $OPENER )
export ROOTER=$(find_alt gksudo kdesudo )
export IMAGEVIEWER=$(find_alt sxviv feh display eog $OPENER )

# Treat single word simple commands without redirection as candidates for resumption of an existing job.
setopt AUTO_RESUME

# List jobs in the long format by default. 
setopt LONG_LIST_JOBS

# Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt NOTIFY

# Run all background jobs at a lower priority. This option is set by default.
unsetopt BG_NICE

# Send the HUP signal to running jobs when the shell exits.
unsetopt HUP

# Report the status of background and suspended jobs before exiting a shell with job control; 
# a second attempt to exit the shell will succeed. 
# NO_CHECK_JOBS is best used only in combination with NO_HUP, else such jobs will be killed automatically
unsetopt CHECK_JOBS
