#!/bin/bash

case $1 in
	*.tar.gz) tar -xf $1 ;;
	*.bz2) tar jxf $1 ;;
	*.tar) tar 0xvf $1;;
	*.zip) unzip $1;;
	*.rar) unar $1;;
	*.7z) 7z x $1 ;;
	*.gz) tar -xvzf $1;;
esac
