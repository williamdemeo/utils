#!/bin/bash
while test $# -gt 0
do
    case "$1" in
        --help)
	    echo 'This script will purge a file from a git repository.'
	    echo 'You must pass the partially qualified path to the file you want to purge.'
	    echo 'For example, if the repo name is math160 and the file you want to purge'
	    echo 'is called exam1-solved.pdf, which resides in the exams directory,'
	    echo 'then from the top level directory of the working tree of the repo,'
	    echo 'run the script as follows: '
	    echo ' '
	    echo '    git-purge.sh exams/exam1-solved.pdf'
	    echo ' '
	    echo
	    echo 'After running the script, if things went well, you have to (manually)'
	    echo 'invoke the following commands:'
	    echo ' '
	    echo '    git push origin --force --all'
	    echo '    git push origin --force --tags'
	    echo ' '
	    echo 'This is based off the information about the git purge process found at'
	    echo ' '
	    echo '    https://help.github.com/articles/remove-sensitive-data/ '
	    echo ' '
	    echo 'What follows is an excerpt from the page cited above with advice about purging.'
	    echo ' '
	    echo 'Tell your collaborators to rebase, not merge, any branches they created off'
	    echo 'of your old (tainted) repository history. After some time has passed and you'
	    echo 'are confident that git filter-branch had no unintended side effects, you can'
	    echo 'force all objects in your local repository to be dereferenced and garbage'
	    echo 'collected with the following commands:'
	    echo ' '
	    echo "    git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin"
	    echo "    git reflog expire --expire=now --all"
	    echo "    git gc --prune=now"
	    echo
            ;;
        *) if [ "$#" -ne 1 ]; 
	    then
	    echo 
	    echo 'You must run the script with exactly one argument that specifies'
	    echo 'which file should be purged.  For example,'
	    echo
	    echo '    git-purge.sh exams/exam1-solved.pdf'
	    echo
	    echo '(purge aborted)'
	    echo
	    exit 1
	    fi
	    eval "git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch $1' --prune-empty --tag-name-filter cat -- --all"
	    echo ' '
	    echo 'If things seem to have gone well, next do:'
	    echo ' '
	    echo '    git push origin --force --all'
	    echo '    git push origin --force --tags'
	    echo ' '
            ;;
    esac
    shift
done

exit 0
