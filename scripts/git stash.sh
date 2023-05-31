#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"

cd ..

cd ..

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    terminal="konsole"
    elif [[ "$OSTYPE" == "msys"* ]]; then
    terminal="start"
fi

main_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@' | grep -E 'main|master')
if [ -z "$main_branch" ]; then
    echo "A branch principal não é 'main' nem 'master'. Por favor, verifique o seu repositório."
    exit 1
fi

branch=$(git rev-parse --abbrev-ref HEAD)

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    $terminal -e "bash -c 'git add .;git stash;git pull;git checkout $main_branch;git pull;git checkout $branch;git stash apply;exec bash'"
    elif [[ "$OSTYPE" == "msys"* ]]; then
    $terminal bash -c "git add .;git stash;git pull;git checkout $main_branch;git pull;git checkout $branch;git stash apply;exec bash"
fi

read -p "Digite a mensagem do comentário do stash: " message
git stash push -m "$message"