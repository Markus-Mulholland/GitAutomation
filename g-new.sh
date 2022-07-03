#!C:/Program\ Files/Git/bin/sh.exe

readonly noChangesString="nothing to commit"

status=$(git status)

if [[ "$status" != *"$noChangesString"* ]]
    then #TODO: Promt to stash changes if they exist.
        echo "Changes found. Exiting..."
        exit 1
fi

checkoutResponseString=$(git checkout staging -q) #TODO: Figure out why running this command still outputs to the terminal without the -q option.

if [[ -z "$checkoutResponseString" ]]
    then
        #pull remote
        stagingPulledResponse=$(git pull)
                
        echo 'Generating branch...'
        checkoutNewBranchResponse=$(git checkout -b MOS-$1_$2 staging -q)

        if [[ -z "$checkoutNewBranchResponse" ]]
            then
                echo 'On new branch. Happy coding!'
        fi
fi