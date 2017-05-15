#!/usr/bin/expect
eval spawn ssh -oStrictHostKeyChecking=no -oCheckHostIP=no usr@$myhost.example.com
#use correct prompt
set prompt ":|#|\\\$"
interact -o -nobuffer -re $prompt return
send "my_password\r"
interact -o -nobuffer -re $prompt return
send "my_command1\r"
interact -o -nobuffer -re $prompt return
send "my_command2\r"
interact
