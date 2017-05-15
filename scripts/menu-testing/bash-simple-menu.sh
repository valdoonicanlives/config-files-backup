#!/bin/bash
           OPTIONS="gedit leafpad youtube Quit"
           select opt in $OPTIONS; do
               if [ "$opt" = "Quit" ]; then
                echo done
                exit
               elif [ "$opt" = "gedit" ]; then
                gedit
				elif [ "$opt" = "leafpad" ]; then
				 leafpad 
				 elif [ "$opt" = "youtube" ]; then
				 google-chrome-beta www.youtube.com
                else
                clear
                echo bad option
               fi
           done
          
