#!C:/Program\ Files/Git/bin/sh.exe

status=$(git status)

branch=$(echo $status | cut -d' ' -f 3)

command="git push --set-upstream origin ${branch}"

eval $command