#!/bin/bash
#
# PURPOSE:
# keep a copy of each file per hostname
# - if we only have the original, save it in the repository
# - if we have the original and a repository copy and if there is a difference, update the repository
# - if we only have the repository copy, put it back with a warning
#
# it wont copy symlinks but their content.
#
# if a copy is renamed from *.hostname to *.default, it will be used for any host
# unless they have a specific *.hostname with alternative content.

# need to run from the script directory
SCRIPT=`realpath -s "$0"`
SCRIPTPATH=`dirname "$SCRIPT"`
cd "$SCRIPTPATH"

# default files to take care of
# have put others in updaterc file DK
ITEMS="bashrc bash_functions config/geany tmux.conf "
# source rcfile if exists, useful to change ITEMS
if [ -e updaterc ]; then . updaterc ; fi

# update from git repository
git pull

# function to copy data: requires $item_SOURCE and $item_DESTINATION
cp_rc() {
    if [ -d "$item_SOURCE" ]; then
	# specific handling if the source is a directory:
	# first create destination directory
	mkdir --parents --verbose "$item_DESTINATION"
	# then copy content from one directory to another 
	cp --verbose --dereference --recursive "$item_SOURCE"/* "$item_DESTINATION"/	
    else
	# simple file
	cp --verbose --dereference --recursive "$item_SOURCE" "$item_DESTINATION"
    fi
}

# actual work
for item in $ITEMS; do
    # defines local and repository files
    item_LOCAL="$HOME/.$item"
    #item_REPOSITORY="$SCRIPTPATH/$item.$HOSTNAME"
    item_REPOSITORY="$SCRIPTPATH/$item"
    item_REPOSITORY_DEFAULT="$SCRIPTPATH/$item.default"

    # always reset vars used by cp_rc()
    item_SOURCE=""
    item_DESTINATION=""

    # if we have both a repository default and repository host version,
    # make sure they differ
    if [ -e "$item_REPOSITORY_DEFAULT" ] && [ -e "$item_REPOSITORY" ] &&
	   cmp -s "$item_REPOSITORY_DEFAULT" "$item_REPOSITORY"; then
	# if they do not differ, remove the useless host specific version
	rm -f "$item_REPOSITORY"
    fi    
     
    # skip if we have neither local or in repository (including default) at all
    if [ ! -e "$item_LOCAL" ] && [ ! -e "$item_REPOSITORY" ] && [ ! -e "$item_REPOSITORY_DEFAULT" ]; then
	echo ".$item missing on both ends"
	continue
    fi

    # only local: save it in the repository, unless it matches the default
    if [ -e "$item_LOCAL" ] && [ ! -e "$item_REPOSITORY" ]; then
	# check if repository default exists
	if [ -e "$item_REPOSITORY_DEFAULT" ]; then
	    # skip if local does not differ from the repository default	
	    if cmp -s "$item_LOCAL" "$item_REPOSITORY_DEFAULT"; then
		echo ".$item OK (default)"
		continue
	    fi
	fi	    
	item_SOURCE="$item_LOCAL"
	item_DESTINATION="$item_REPOSITORY"
	cp_rc
	continue
    fi

    # only repository
    if [ ! -e "$item_LOCAL" ] && [ -e "$item_REPOSITORY" ]; then
	echo "   Odd, we only have the following file in repository:"
	echo "   (if you no longer want it, please remove it from both places)"
	item_SOURCE="$item_REPOSITORY"
	item_DESTINATION="$item_LOCAL"
	cp_rc
	continue
    fi
    
    # only repository default
    if [ ! -e "$item_LOCAL" ] && [ ! -e "$item_REPOSITORY" ] && [ -e "$item_REPOSITORY_DEFAULT" ]; then
	echo "   No local copy but repository default exists:"
	item_SOURCE="$item_REPOSITORY_DEFAULT"
	item_DESTINATION="$item_LOCAL"
	cp_rc
	continue
    fi
    
    
    # both local and repository
    # check if there is a difference, using diff to be verbose about it
    if [ -e "$item_LOCAL" ] && [ -e "$item_REPOSITORY" ]; then
	diff "$item_LOCAL" "$item_REPOSITORY"
    elif [ -e "$item_LOCAL" ] && [ ! -e "$item_REPOSITORY" ] && [ -e "$item_REPOSITORY_DEFAULT" ]; then
	diff "$item_LOCAL" "$item_REPOSITORY_DEFAULT"
	echo "   Local copy differents from repository default, a new host specific file will be created"
	echo "   To update the default, move this new file to the default"
    else
	# if we end up here, there is a bug earlier
	echo ".$item failure to evaluate status"
	continue
    fi

    # take action depending on diff result
    if [ $? -ne 0 ]; then
	# if there is, overwrite/create host specific with the local copy
	item_SOURCE="$item_LOCAL"
	item_DESTINATION="$item_REPOSITORY"
	cp_rc
    else
	echo ".$item OK"
    fi
	
done

# update to git repository
git add *
git commit -am 'auto'
git push

# EOC
