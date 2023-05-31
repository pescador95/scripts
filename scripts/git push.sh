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

current_branch=$(git branch --show-current)

$terminal bash -c "git push origin $current_branch;cmd /K"