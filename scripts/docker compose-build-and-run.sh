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

current_branch=$(git branch --show-current)

    echo "Executando o script na branch: $current_branch"

    echo "Executando docker-compose down..."
    docker-compose down
    echo "Apagando imagens e containers..."
    docker image rm -f  `docker images -q` && docker container rm -f `docker ps -aq`
    echo "Construindo imagem do banco de dados..."
    docker build -f Dockerfile.postgres .
    echo "Constrindo imagem da API quarkus..."
    docker build -f Dockerfile.quarkus .
    echo "Iniciando docker-compose..."
    docker-compose up -d
    echo "Containers em execução: ##################################"
    docker ps
    echo "##########################################################"
    read -n 1 -s -r -p "docker-compose Executado com sucesso! Pressione qualquer tecla para sair."
