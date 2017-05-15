source /home/dka/bin/bashful-execute

# ls recent items at bottom with green TODAY yellow YESTERDAY substituted
# https://www.reddit.com/r/archlinux/comments/41s1w4/what_is_your_favorite_one_liner_to_use/cz50y1m
lsrecent() {
    ls -vAFq --color=yes -got --si --time-style=long-iso "$@" \
    | sed "s/$(date +%Y-%m-%d)/\x1b[32m     TODAY\x1b[m/;s/$(date +'%Y-%m-%d' -d yesterday)/\x1b[33m YESTERDAY\x1b[m/" | tac
}
#====
showprocess () {
  ps aux | grep $1
}
#The above function can be used like showprocess firefox, and it will list all the processes with that #name.
#====
#Move-follow ("mvf") will move files like the regular mv command, then change directory to the directory that you just moved the files to
#cpf the same only it copies the file 
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }

cpf() { cp "$@" && goto "$_"; }

mvf() { mv "$@" && goto "$_"; }
#================
#function below to use with dirlog (cli navigation)
c() {
  dir="$(dirlog-cd "$@")"
  if [ "$dir" != "" ]; then
    cd "$dir" && ls
  fi
}
#=================
#optimize resize using cjpeg
optimage() {
	cjpeg -quality 70 -outfile cjpeg-compressed-image.jpg "$1"
}
#reduce size and dimensions, use imagemagick to resize and cjpeg to resample-optimize
resizeand() {
  convert -resize 50% "$1" TGA:- | 
  cjpeg -outfile cjpeg-compressandresize-image.jpg -targa
}
#============
# check stock, type stock slv or whatever
stock () 
{ 
lynx -dump "http://www.google.com/finance?client=ob&q=${1}" | sed 's/.*']'//' | perl -00ne "print if /Watch this stock/i" | sed 's/Watch this stock//' | sed 's/Disclaimer//' | sed '/^$/d' | sed 's/Currency in USD//'
}
#===============
# YOUTUBE functions:
ytdl-18(){
clear
printf "%s\n" "" "Enter the youtube video link: " ""
read link
clear
echo "Begining Download wait a moment"
youtube-dl -f 18 --output "/home/dka/YouTube/%(title)s.%(ext)s" "$link"
echo "Finished downloading, video saved to /dka/YouTube/"
}

ytdl-22(){
clear
printf "%s\n" "" "Enter the youtube video link: " ""
read link
clear
echo "Begining Download wait a moment"
youtube-dl -f 22 --output "/home/dka/YouTube/%(title)s.%(ext)s" "$link"
echo "Finished downloading, video saved to /dka/YouTube/"
}


# Youtube extract mp3 function
yt2mp3() { youtube-dl -c --restrict-filenames --extract-audio --audio-quality 0 --audio-format mp3 -o "%(title)s.%(ext)s" $@ ;}
#================
#make a dir and move into it - so type mcd mydir
mcd () {
    mkdir -p $1
    cd $1
}

# script create a file list with Installed packages and current time
makepacklist () {
   cd /home/dka/text-files-home
   rm -r packages
   touch packages
   date >> packages
   pacman -Qqe >> packages
   cat packages
   }
#=====================
#optimize the images I upload to web to be 690px or less,uses imagemagick's mogrify command
#Warning does not make a backup of original image!
#forweb() 
#{
#	echo "this will resize the image and WONT make a backup"
#	sleep 4s;
#	mogrify -resize 690\> *.jpg
#}
forweb()
{
OPTIONS="yes quit backup"
			   echo "WARNING this will resize the image and WONT make a backup copy"
               select opt in $OPTIONS; do
                   if [ "$opt" = "quit" ]; then
                    echo done
                    exit
                   elif [ "$opt" = "backup" ]; then
                    bu "$@"
                   elif [ "$opt" = "yes" ]; then
                    mogrify -resize 690\> "$@"
                    exit
                   else
                    clear
                    echo bad option
                   fi
               done	
}
#========================
#make a backup of a file eg. your /etc/fstab file
#either specify it and the path like
#sudo bu /etc/fstab
#or cd into the dir of the file and just use bu and filename eg.
#sudo bu fstab
bu () { cp $1 ${1}-`date +%Y.%m.%d-%H.%M`.backup ; }
#====================================================================================

function climusic() {
   mpd
   /usr/bin/ncmpcpp
   mpd --kill
}
#===============
# REMIND ME, ITS IMPORTANT! {{{
    # usage: remindme <time> <text>
    # e.g.: remindme 10m "omg, the pizza"
remindme() { sleep $1 && zenity --info --text "$2" & }
#==================
# type  unpack filetounpack.zip
unpack() {
    for file in "$@"; do
        if [ -f "$file" ]; then
            local file_type=$(file -bizL "$file")
            case "$file_type" in
                *application/x-tar*|*application/zip*|*application/x-zip*|*application/x-cpio*)
                    bsdtar -x -f "$file" ;;
                *application/x-gzip*)
                    gunzip -d -f "$file" ;;
                *application/x-bzip*)
                    bunzip2 -f "$file" ;;
                *application/x-rar*)
                    7z x "$file" ;;
                *application/octet-stream*)
                    local file_type=$(file -bzL "$file")
                    case "$file_type" in
                        7-zip*) 7z x "$file" ;;
                        *) echo -e "Unknown filetype for '$file'\n$file_type" ;;
                    esac ;;
                *)
                    echo -e "Unknown filetype for '$file'\n$file_type" ;;
            esac
        else
            echo "'$file' is not a valid file"
        fi
    done
}
#forgot I already had this function by Helmut which also works
# ARCHIVE EXTRACTOR {{{
    extract() {
      clrstart="\033[1;34m"  #color codes
      clrend="\033[0m"

      if [[ "$#" -lt 1 ]]; then
        echo -e "${clrstart}Pass a filename. Optionally a destination folder. You can also append a v for verbose output.${clrend}"
        exit 1 #not enough args
      fi

      if [[ ! -e "$1" ]]; then
        echo -e "${clrstart}File does not exist!${clrend}"
        exit 2 #file not found
      fi

      if [[ -z "$2" ]]; then
        DESTDIR="." #set destdir to current dir
      elif [[ ! -d "$2" ]]; then
        echo -e -n "${clrstart}Destination folder doesn't exist or isnt a directory. Create? (y/n): ${clrend}"
        read response
        #echo -e "\n"
        if [[ $response == y || $response == Y ]]; then
          mkdir -p "$2"
          if [ $? -eq 0 ]; then
            DESTDIR="$2"
          else
            exit 6 #Write perms error
          fi
        else
          echo -e "${clrstart}Closing.${clrend}"; exit 3 # n/wrong response
        fi
      else
        DESTDIR="$2"
      fi

      if [[ ! -z "$3" ]]; then
        if [[ "$3" != "v" ]]; then
          echo -e "${clrstart}Wrong argument $3 !${clrend}"
          exit 4 #wrong arg 3
        fi
      fi

      filename=`basename "$1"`

      #echo "${filename##*.}" debug

      case "${filename##*.}" in
        tar)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (uncompressed tar)${clrend}"
          tar x${3}f "$1" -C "$DESTDIR"
          ;;
        gz)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
          tar x${3}fz "$1" -C "$DESTDIR"
          ;;
        tgz)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
          tar x${3}fz "$1" -C "$DESTDIR"
          ;;
        xz)
          echo -e "${clrstart}Extracting  $1 to $DESTDIR: (gip compressed tar)${clrend}"
          tar x${3}f -J "$1" -C "$DESTDIR"
          ;;
        bz2)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (bzip compressed tar)${clrend}"
          tar x${3}fj "$1" -C "$DESTDIR"
          ;;
        zip)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (zipp compressed file)${clrend}"
          unzip "$1" -d "$DESTDIR"
          ;;
        rar)
          echo -e "${clrstart}Extracting $1 to $DESTDIR: (rar compressed file)${clrend}"
          unrar x "$1" "$DESTDIR"
          ;;
        7z)
          echo -e  "${clrstart}Extracting $1 to $DESTDIR: (7zip compressed file)${clrend}"
          7za e "$1" -o"$DESTDIR"
          ;;
        *)
          echo -e "${clrstart}Unknown archieve format!"
          exit 5
          ;;
      esac
    }
# ARCHIVE COMPRESS {{{
    compress() {
      if [[ -n "$1" ]]; then
        FILE=$1
        case $FILE in
        *.tar ) shift && tar cf $FILE $* ;;
    *.tar.bz2 ) shift && tar cjf $FILE $* ;;
     *.tar.gz ) shift && tar czf $FILE $* ;;
        *.tgz ) shift && tar czf $FILE $* ;;
        *.zip ) shift && zip $FILE $* ;;
        *.rar ) shift && rar $FILE $* ;;
        esac
      else
        echo "usage: compress <foo.tar.gz> ./foo ./bar"
      fi
    }

#==================================================
# FUZZY FINDER & SURFRAW
#use surfraw with dmenu
dmsr() { surfraw "$(cat ~/.config/surfraw/bookmarks | sed '/^$/d' | sort -n | dmenu -i)" ;}
#
fzf-sr() { surfraw "$(cat ~/.config/surfraw/bookmarks | sed '/^$/d' | sort -n | fzf -e)" ;}
# hotkey to run above function instead of typeing fzf-surfraw
bind '"\C-W":"fzf-sr\n"'
#--------------------------------------
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
# Below to open a file
fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}
# Below find a file and open in default app like a jpg in sxiv etc
fzf-locate() { xdg-open "$(locate "*" | fzf -e)" ;}
#
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
# to use it to launch gui apps-doesn't really use dmenu i'ts just a name
fzf-dmenu() { 
    # note: xdg-open has a bug with .desktop files, so we cant use that shit
    selected="$(ls /usr/share/applications | fzf -e)"
    nohup `grep '^Exec' "/usr/share/applications/$selected" | tail -1 | sed 's/^Exec=//' | sed 's/%.//'` >/dev/null 2>&1&
}
# hotkey to run the above function (Ctrl+O)
bind '"\C-O":"fzf-dmenu\n"'
#
# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}
# v - open files in ~/.viminfo
# could use another source list instead of .viminfo eg .testlist
v() {
  local files
  #files=$(grep '^>' ~/.viminfo | cut -c3- |
  files=$(cat ~/.testlist |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | fzf-tmux -d -m -q "$*" -1) && nvim ${files//\~/$HOME}
}
#Also works with pick
w() {
  local files
  #files=$(grep '^>' ~/.viminfo | cut -c3- |
  files=$(cat ~/.testlist |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | pick -d  "$*") && nvim ${files//\~/$HOME}
}
#Also works with sentaku,but with sentaku you dont start typing you choose from a list use j,k to go up down
r() {
  local files
  #files=$(grep '^>' ~/.viminfo | cut -c3- |
  files=$(cat ~/.testlist |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | sentaku ) && nvim ${files//\~/$HOME}
}
#Try with slmenu
s() {
    local files
  #files=$(grep '^>' ~/.viminfo | cut -c3- |
  files=$(cat ~/.testlist |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | slmenu ) && nvim ${files//\~/$HOME}
}
#-----------------------------------------------------
#gotbletus snippets using fzf
fzf-snippy() { 
    selected="$(cat ~/.fzfsnippetrc | sed '/^$/d' | sort -n | fzf -e -i )"
    # remove tags, leading and trailing spaces, also no newline
    #this was the og -echo "$selected" | sed -e s/\;\;\.\*\$// | sed 's/^[ \t]*//;s/[ \t]*$//' | tr -d '\n' | xclip -selection clipboard
    echo "$selected" | sed -e s/\;\;\.\*\$// | sed 's/^[ \t]*//;s/[ \t]*$//' | xclip -selection clipboard
}
# hot key for above function
bind '"\C-y":"fzf-snippy\n"'
# for fzfsnippypw
fzf-snippypw() { 
	ccrypt --decrypt --key kered00 /home/dka/.snippy/fzfsnippypw.cpt
    selected="$(cat  '/home/dka/.snippy/fzfsnippypw' | sed '/^$/d' | sort -n | fzf -e -i )"
    # remove tags, leading and trailing spaces, also no newline
    #this was the og -echo "$selected" | sed -e s/\;\;\.\*\$// | sed 's/^[ \t]*//;s/[ \t]*$//' | tr -d '\n' | xclip -selection clipboard
    echo "$selected" | sed -e s/\;\;\.\*\$// | sed 's/^[ \t]*//;s/[ \t]*$//' | xclip -selection clipboard
    ccrypt --encrypt --key kered00 /home/dka/.snippy/fzfsnippypw
}
# hotkey to run above function instead of typeing fzf-snippypw
bind '"\C-p":"fzf-snippypw\n"'
#---------
fzf-multisnippy() { 
    # location of snippets
    dir=~/.fzfmultisnippet

    # merge filename and tags into single line
    results=$(for FILE in $dir/*
    do
        getname=$(basename $FILE)
        gettags=$(head -n 1 $FILE)

        echo "$getname $gettags" 

    done)

    # copy content into clipboard without tags
    filename=$(echo "$(echo $results | fzf -e -i )" | cut -d' ' -f 1)
    sed 1d $dir/$filename | xclip -selection clipboard
}
# TO EDIT THEM
# edit single line snippet
cfg-snippetrc() { $EDITOR ~/.fzfsnippetrc ;}

# edit multiline snippet
cfg-multisnippetrc() { $EDITOR ~/.fzfmultisnippet/"$(ls ~/.fzfmultisnippet | fzf -e -i)" ;}

#==========================
#This one for using the simple server script
# https://www.youtube.com/watch?v=FFIjMYzkHhc
# type localhost:8000  in web browser address to see it
httpserver() { python2.7 ~/bin/SimpleHTTPServerWithUpload.py ${1:-8000} ;} 
#========================
#below set of functions so you can search google or bing or wikipedia the top encode one is needed for the others

function encode() { echo -n $@ | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg';}
function GS() { google-chrome-beta http://www.google.com/search?hl=en#q="`encode $@`" ;}
function bing() { google-chrome-beta http://www.bing.com/search?q="`encode $@`" ;}
function wiki() { chromium http://en.wikipedia.org/w/index.php?search="`encode $@`" ;}
#========================================================================================

#Simple bookmark system - also works in midnight commander
# type go vids to go to the videos dir  or go docs to goto documents (was g but changed it to go DK)
# this also works in zsh prompt  jump doesnt
# these shortcuts work in midnight commander but j docs(jump) and z docs(fasd) don't
# doesn't work in ranger (or vifm) of course but that has it's own bookmark system 
getBookmark() {
    case "$1" in
    video|vids|vid) echo "/home/dka/videos" ;; #shortcuts to "/home/dka/videos"
    images|img|pics|pictures) echo "/home/dka/Pictures" ;;
    music) echo "/media/ElementsA/shared-music" ;;
    config) echo "/home/dka/.config" ;;	
    dloads|dwnloads|downloads) echo "/home/dka/Downloads" ;;
    doc|docs|documents) echo "/home/dka/Documents" ;;
    dt|dtop|desk|desktop) echo "/home/dka/Desktop" ;;	
    bin|mybin) echo "/home/dka/bin" ;;
    mygits) echo "/home/dka/mygits" ;; 
    home) echo "/home/dka" ;;
    textfiles|text-files) echo "text-files-home" ;;
    elements|external) echo "/media/ElementsA" ;;
    root) echo "/" ;;
    etc) echo "/etc" ;;
    *) echo "" ;;
    esac
}
listbookmarks() {
	echo "video vids vid"
	echo "music"
	echo "images img pics pictures"
	echo "config"
	echo "dloads dwnloads downloads"
	echo "doc docs documents"
	echo "bin mybin"
	echo "mygits"
	echo "home"
	echo "textfiles text-files"
	echo "elements external"
	echo "root "
	echo "etc"
}
#Moves files to a bookmarked dir: Type mto file1 file2 bookmarkname
# mto vid1.avi vid2.avi videos
mto () {
    eval lastarg=\${$#}
    targetdir=`getBookmark $lastarg`
    echo "Moving files to $targetdir"
    if [ -n "$targetdir" ]; then
        for dir in "$@";
            do
                if [ "$dir" != $lastarg ]; then
                    mv -iv "$dir" "$targetdir"
                fi
            done
    fi
}
#Copies files to a bookmarked dir: cto file1 file2 bookmarkname
#cto file1.jpg file2.jpg file3.jpg pics
cto () {
    eval lastarg=\${$#}
    targetdir=`getBookmark $lastarg`
    echo "Copying files to $targetdir"
    if [ -n "$targetdir" ]; then
        for dir in "$@";
            do
                if [ "$dir" != $lastarg ]; then
                    cp -iv "$dir" "$targetdir"
                fi
            done
    fi
}
#Go to a bookmarked dir: go vids
go () {
    dir=`getBookmark $1`
    if [ -n "$dir" ]; then
        cd "$dir"
    fi
}
#Go and list: gl vids
gl () {
    g $1
    ls
}
#Go and list with details: gll vids
gll () {
    go $1
    ll
}
#List contents of a bookmarked dir without going there: list vids
list () {
    dir=`getBookmark $1`
    echo $dir
    if [ -n "$dir" ]; then
        ls "$dir"
    fi
}
#Same as "list" but with details: llist vids
llist () {
    dir=`getBookmark $1`
    echo $dir
    if [ -n "$dir" ]; then
        ll "$dir"
    fi
}
#=========================================
# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
#below, simple and works also autocomplete type say jump Doc then tab to get Documents
export MARKPATH=$HOME/.marks
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

# this is for zsh :

#function _completemarks {
#	reply=($(sed 's/\(.*\)|.*/\1/' $HOME/.marks))
#}

#compctl -K _completemarks cdm
#compctl -K _completemarks delmarkark() {
#==================================================

#type "mycd" and a list of directories appears which you frequently cd to. If you know the number you can just type "mycd 2".To add a directory to the list you just type "mycd /tmp/foo/somedirectory".
# if it doesnt work replace the print statments with echo

function mycd {
MYCD=/home/dka/mycd.txt
#touch ${MYCD}

typeset -i x
typeset -i ITEM_NO
typeset -i i
x=0

if [[ -n "${1}" ]]; then
   if [[ -d "${1}" ]]; then
      echo "${1}" >> ${MYCD}
      sort -u ${MYCD}
      FOLDER=${1}
   else
      i=${1}
      FOLDER=$(sed -n "${i}p" ${MYCD})
   fi
fi

if [[ -z "${1}" ]]; then
   echo ""
   cat ${MYCD} | while read f; do
      x=$(expr ${x} + 1)
      echo "${x}. ${f}"
   done
   echo "Select #"
   read ITEM_NO
   FOLDER=$(sed -n "${ITEM_NO}p" ${MYCD})
fi

if [[ -d "${FOLDER}" ]]; then
   cd ${FOLDER}
fi

}


#==================================================================================
#url-bkmarks function
# Add url-bookmark entries to a .urlbms file
# I changed it so you don't type in the url anymore just highlight a url and then in
#terminal type  addurl
# you choose a url to launch by using the seperate dmenu script with keyboard combo ALTGR + w
addurl ()
{
    if [ -e .urlbms ] ; then
    # I added line below to automatically copy into clipboard highlighted url, remove to return to original funct.
		xsel -n -t 1000 >> .urlbms
		echo >> .urlbms
       # echo "$1" >> .urlbms # uncomment this line and comment out line above to return to orig. function
    else
        echo "Bookmarks file not found!"
    fi
}
#=================================================================================
#### Standby and shutdown functions #######
function standby()
{
systemctl suspend
}
function suspend()
{
systemctl suspend
}
function zzz()
{
systemctl suspend
}
#function shutdown()
#{
#echo "<kered0>" | sudo -S shutdown -h now
#}
#
function shutdown()
{
systemctl poweroff
}
#=====================================================================
# 132 is the @ key
hm()
{
sleep 4s;
xdotool type 'elwoode'
sleep 0.5s
xdotool key 132
xdotool type 'hotmail.co.uk'
xdotool key Tab
xdotool type 'hotmailkered0'
xdotool key "Return"
}
#
cbhm()
{
sleep 4s;
xdotool type 'chrberendsen'
sleep 0.5s
xdotool key 132
xdotool type 'hotmail.com'
xdotool key Tab
xdotool type 'a$tnetk1n'
xdotool key "Return"
}
#
em()
{
sleep 4s;
xdotool type 'elwoode'
sleep 0.5s
xdotool key 132
xdotool type 'hotmail.co.uk'
}
adent()
{
sleep 4s;
xdotool type 'arthurdentgwm'
sleep 0.5s
xdotool key 132
sleep 0.5s
xdotool type 'gmail.com'
}
#========================================================================
####### notes functions below #############
# Type webn to open web-notes in vim
# Type qn then some text that you want adding to qnotes.txt
# Type view-qn to open the file in text editor
# Type todo  then some text to add it to your todo.txt file
#
function webn() {
  vim ~/text-files/web-notes.txt 
}

function qn() {
   echo $(date)'\n'$@ >> ~/text-files-home/qnotes.txt
  #echo $@ >> ~/text-files-home/qnotes.txt
}

function view-qn() {
	vim -c '$|startinsert!' ~/text-files-home/qnotes.txt
}

function todo() {
  echo $@ >> ~/text-files-home/todo.txt
}

function view-todo() {
  vim -c '$|startinsert!' ~/text-files-home/todo.txt
}

function view-clips() {
 vim ~/quick-clippings
}
#To open vim in vimwiki
vimwiki() {
   nvim -c :VimwikiIndex
}
# the funct.below uses a single file called .notes not a folder
nn() {
    local NOTE_FILE=$HOME/.notes
    #if file doesn't exist, create it
    [[ -f "$NOTE_FILE" ]] || touch "$NOTE_FILE"
   
    #no arguments, edit file
    if [[ -z "$1" ]]; then
       vim "+set number" "$NOTE_FILE"
    elif (( $1 )); then tail -"$1" "$NOTE_FILE"
    elif [[ "$1" == "-s" ]]; then /bin/grep -E --color=always -i -C 1 "$2" "${NOTE_FILE}"
    elif [[ "$1" == "-h" || $1 == "--help" ]]; then
        printf "nn [options|note]: Make quick notes\n"
        printf "Options: <note>\t\twrite <note> to '${NOTE_FILE}'\n"
        printf "\t\t\tshow '${NOTE_FILE}'\n"
        printf "\t<number>\tshow last <number> lines of '${NOTE_FILE}'\n"
        printf "\t-s <regex>\tsearch '${NOTE_FILE}' for <regex>\n"
    #append all arguments to file
    else
        echo ">> '$@'" >> "$NOTE_FILE"
    fi
} 
# the functions below use note files stored in ~/notes folder
# http://jasonwryan.com/blog/2012/09/01/notes-updated/
# the command n nameofnote to take a new note and nls to list all available notes in your notes directory.
n() {
local arg files=(); for arg; do files+=( ~/"notes/$arg" ); done
${EDITOR:-vi} "${files[@]}"
}

nls() {
tree -CR --noreport $HOME/notes | awk '{ 
    if (NF==1) print $1; 
    else if (NF==2) print $2; 
    else if (NF==3) printf "  %s\n", $3 
    }'
}

 # TAB completion for notes
_notes() {
local files=($HOME/notes/**/"$2"*)
    [[ -e ${files[0]} ]] && COMPREPLY=( "${files[@]##~/notes/}" )
}
complete -o default -F _notes n
