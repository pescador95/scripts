#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"

cd ..

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if grep -qi "debian" /etc/os-release; then
        terminal="konsole"
    else
        terminal="gnome-terminal"
    fi
elif [[ "$OSTYPE" == "msys"* ]]; then
    terminal="start"
else
    echo "Script não suportado para este Sistema Operacional."
    exit 1
fi

main_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@' | grep -E 'main|master')
if [ -z "$main_branch" ]; then
    echo "A branch principal não é 'main' nem 'master'."
    exit 1
fi

branch=$(git rev-parse --abbrev-ref HEAD)

$terminal -e "bash -c 'git add .;git stash;git pull;git checkout $main_branch;git pull;git checkout $branch;git stash apply;exec bash'"