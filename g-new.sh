#!C:/Program\ Files/Git/bin/sh.exe

readonly no_changes_string="nothing to commit"
readonly NOTICE='\033[0;35m'
readonly INPUT='\033[0;33m'
readonly STANDARD='\033[0;37m'

status=$(git status)

if [[ "$status" != *"$no_changes_string"* ]]
    then
        changes=$(git status -s)
        echo -e "You have some uncommited changes: \n$NOTICE$changes$STANDARD"
        echo -e "Would you like to stash these changes and continue? (Y/n): $INPUT\c"
        read stash_choice
        echo -e "$STANDARD"
        stash_choice=$(echo $stash_choice | tr '[:upper:]' '[:lower:]')
        if [[ -z "$stash_choice" ]] || [[ "$stash_choice" == "y" ]]
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

checkout_response_string=$(git checkout $1 -q) #TODO: Figure out why running this command still outputs to the terminal without the -q option.

if [[ -z "$checkout_response_string" ]]
    then
        #pull remote
        staging_pulled_response=$(git pull)
                
        echo 'Generating branch...'
        checkout_new_branch_response=$(git checkout -b PINPA-$2_$3 $1 -q)

        if [[ -z "$checkout_new_branch_response" ]]
            then
                echo 'On new branch. GET IT DONE'
        fi
fi