#!/bin/bash

current_path=$(dirname "$0")

cd "$current_path"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    terminal="gnome-terminal"
elif [[ "$OSTYPE" == "msys"* ]]; then
    terminal="start"
fi

current_branch=$(git branch --show-current)

$terminal bash -c "git push origin $current_branch;cmd /K"
