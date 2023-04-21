#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"

branch=$(git rev-parse --abbrev-ref HEAD)

remote=$(git config --get remote.origin.url)
if [[ "$remote" =~ .*github\.com.* ]]; then
    remote_branch="main"
else
    remote_branch="master"
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    gnome-terminal -e "bash -c 'git pull;git switch $remote_branch;git pull;git switch $branch;exec bash'"
elif [[ "$OSTYPE" == "msys"* ]]; then
    start bash -c "git pull;git switch $remote_branch;git pull;git switch $branch;git push -u origin;exec bash"
fi
