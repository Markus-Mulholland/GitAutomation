#!C:/Program\ Files/Git/bin/sh.exe

status=$(git status)
echo $branch

branch=$(echo $status | cut -d' ' -f 3)

echo "git push --set-upstream origin ${branch}"