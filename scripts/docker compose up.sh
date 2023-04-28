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

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    $terminal -e "bash -c 'docker-compose up;exec bash'"
elif [[ "$OSTYPE" == "msys"* ]]; then
    $terminal bash -c "docker-compose up;exec bash"
fi