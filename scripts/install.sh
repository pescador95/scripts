#!/bin/bash

current_path=$(dirname "$0")

cd "$current_path"

cd ..

cd ..

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    terminal="konsole"
    elif [[ "$OSTYPE" == "msys"* ]]; then
    terminal="start"
fi

branch=$(git rev-parse --abbrev-ref HEAD)

remote=$(git config --get remote.origin.url)
if [[ "$remote" =~ .*github\.com.* ]]; then
    remote_branch="main"
else
    remote_branch="master"
fi

current_branch=$(git branch --show-current)

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    $terminal -e "bash -c 'git fetch origin;cd backend;mvn clean install;exec bash'" &
    $terminal -e "bash -c 'cd telegram;npm install;exec bash'" &
    elif [[ "$OSTYPE" == "msys"* ]]; then
    $terminal bash -c "git fetch origin;cd backend;mvn clean install;cmd /K" &
    $terminal bash -c "cd telegram;npm install;cmd /K" &
fi