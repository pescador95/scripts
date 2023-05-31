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