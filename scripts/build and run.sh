#!/bin/bash

current_path=$(dirname "$0")

cd "$current_path"

cd ..

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    terminal="gnome-terminal"
elif [[ "$OSTYPE" == "msys"* ]]; then
    terminal="start"
fi

remote=$(git config --get remote.origin.url)
if [[ "$remote" =~ .*github\.com.* ]]; then
    remote_branch="main"
else
    remote_branch="master"
fi

current_branch=$(git branch --show-current)

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    $terminal -e "bash -c 'git fetch origin;git checkout $remote_branch;git pull origin $remote_branch;cd backend;mvn clean package;quarkus build;cd target;cd quarkus-app;java -jar quarkus-run.jar;exec bash'"
elif [[ "$OSTYPE" == "msys"* ]]; then
    $terminal bash -c "git fetch origin;git checkout $remote_branch;git pull origin $remote_branch;cd backend;mvn clean package;quarkus build;cd target;cd quarkus-app;java -jar quarkus-run.jar;cmd /K"
fi
