#!/bin/bash

current_path=$(dirname "$0")

cd "$current_path"

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

remote=$(git config --get remote.origin.url)
if [[ "$remote" =~ .*github\.com.* ]]; then
    remote_branch="main"
else
    remote_branch="master"
fi

current_branch=$(git branch --show-current)

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    $terminal -e "bash -c 'cd backend;cd target;cd quarkus-app;java -jar quarkus-run.jar;exec bash'"
elif [[ "$OSTYPE" == "msys"* ]]; then
    $terminal bash -c "cd backend;cd target;cd quarkus-app;java -jar quarkus-run.jar;cmd /K"
fi
