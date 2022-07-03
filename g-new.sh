#!C:/Program\ Files/Git/bin/sh.exe

readonly noChangesString="nothing to commit"
readonly NOTICE='\033[0;35m'
readonly INPUT='\033[0;33m'
readonly STANDARD='\033[0;37m'

status=$(git status)

if [[ "$status" != *"$noChangesString"* ]]
    then #TODO: Promt to stash changes if they exist.
        changes=$(git status -s)
        echo -e "You have some uncommited changes: \n$NOTICE$changes$STANDARD"
        echo -e "Would you like to stash these changes and continue? (Y/n): $INPUT\c"
        read stashChoice
        echo -e "$STANDARD"
        stashChoice=$(echo $stashChoice | tr '[:upper:]' '[:lower:]')
        if [[ -z "$stashChoice" ]] || [[ "$stashChoice" == "y" ]]
            then
                output=$(git stash -q)
                if [[ -n "$output" ]]
                    then
                        echo $output
                        exit 1
                fi
                    
            else
                echo "Exiting..."
                exit 1
        fi
fi

checkoutResponseString=$(git checkout $1 -q) #TODO: Figure out why running this command still outputs to the terminal without the -q option.

if [[ -z "$checkoutResponseString" ]]
    then
        #pull remote
        stagingPulledResponse=$(git pull)
                
        echo 'Generating branch...'
        checkoutNewBranchResponse=$(git checkout -b MOS-$2_$3 $1 -q)

        if [[ -z "$checkoutNewBranchResponse" ]]
            then
                echo 'On new branch. Happy coding!'
        fi
fi