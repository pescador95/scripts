#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"

cd ..

cd ..

cd ..

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    terminal="konsole"
    elif [[ "$OSTYPE" == "msys"* ]]; then
    terminal="start"
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    $terminal -e "bash -c 'docker-compose -p tcc-appagendamento start;exec bash'"
    elif [[ "$OSTYPE" == "msys"* ]]; then
    $terminal bash -c "docker-compose -p tcc-appagendamento start;exec bash"
fi