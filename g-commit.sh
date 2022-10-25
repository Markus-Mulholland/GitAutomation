#!C:/Program\ Files/Git/bin/sh.exe

readonly NOTICE='\033[0;35m'
readonly INPUT='\033[0;33m'
readonly STANDARD='\033[0;37m'

stash_status=$(git stash list)

if [[ -n "$stash_status" ]]
    then
        stashed_files=$(git stash show)

        echo "Stash present: \n$NOTICE$stashed_files$STANDARD"
        echo -e "$stashed_files \nPop? (Y/n): $INPUT\c"
        read stashChoice

        echo -e "$STANDARD"

        stash_choice=$(echo $stashChoice | tr '[:upper:]' '[:lower:]')
        if [[ -z "$stash_choice" ]] || [[ "$stash_choice" == "y" ]]
            then
                output=$(git stash pop -q)
                if [[ -n "$output" ]]
                    then
                        echo $output
                        exit 1
                fi
        fi
fi
# stage files

commit_status=$(git add . -q) # -q does not work here. Figure out how to run this command in quiet mode(Ignore warningss)
# commit
# promt the user to push