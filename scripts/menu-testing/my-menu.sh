#!/bin/bash


while true
do
clear
echo "============================"
echo "Choice Menu -----"
echo -e "\n"
echo "Enter 1 for quick-notes 1: "
echo "Enter 2 for webnotes 2: "
echo "Enter 3 for todo 3: "
echo "Enter 4 for youtube 4: "
echo "Enter q to exit q: "
echo -e "\n"
echo -e "Enter your choice >\c"
read answer
case "$answer" in
1) leafpad ~/text-files/qnotes.txt ;;
2) leafpad ~/text-files/web-notes.txt ;;
3) leafpad ~/text-files/todo.txt ;;
4) chromium www.youtube.com ;;
q) exit ;;
esac
echo -e "enter return to continue \c"
read input
done

