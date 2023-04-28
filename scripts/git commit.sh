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

if [ "$current_branch" != "main" ] && [ "$current_branch" != "master" ]; then
    read -p "Entre com a mensagem do commit: " commit_msg

    git add .
    git commit -m "$commit_msg"

    git push -u origin "$current_branch"

    read -n 1 -s -r -p "Commit enviado com sucesso. Pressione qualquer tecla para sair."
else
    echo "Não é permitido fazer commit na branch 'main' ou 'master'."
    read -n 1 -s -r -p "Pressione qualquer tecla para sair."
fi