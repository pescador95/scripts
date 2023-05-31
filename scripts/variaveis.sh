#!/bin/bash

# Função para exportar variáveis de ambiente
export_variables() {
    echo "Exportando variáveis de ambiente..."
    if [[ "$OSTYPE" == "msys" ]]; then
        echo "APIRESTAURANTE_URL=$APIRESTAURANTE_URL" > exported_variables.txt
        echo "API_BACKEND_LOGIN=$API_BACKEND_LOGIN" >> exported_variables.txt
        echo "API_BACKEND_PASSWORD='$API_BACKEND_PASSWORD'" >> exported_variables.txt
        echo "API_KEY=$API_KEY" >> exported_variables.txt
        echo "CALENDAR_ID=$CALENDAR_ID" >> exported_variables.txt
        echo "CALENDAR_URL=$CALENDAR_URL" >> exported_variables.txt
        echo "CALENDAR_URL_BASICS=$CALENDAR_URL_BASICS" >> exported_variables.txt
        echo "DATABASE_PASSWORD=$DATABASE_PASSWORD" >> exported_variables.txt
        echo "DATABASE_URL=$DATABASE_URL" >> exported_variables.txt
        echo "DATABASE_USER=$DATABASE_USER" >> exported_variables.txt
        echo "EMAIL_PWD=$EMAIL_PWD" >> exported_variables.txt
        echo "EMAIL_USER=$EMAIL_USER" >> exported_variables.txt
        echo "KEY=$KEY" >> exported_variables.txt
        echo "QUARKUS_BASEURL=$QUARKUS_BASEURL" >> exported_variables.txt
        echo "QUARKUS_PORT=$QUARKUS_PORT" >> exported_variables.txt
        echo "TELEGRAM_TOKEN=$TELEGRAM_TOKEN" >> exported_variables.txt
    else
        env > exported_variables.txt
    fi
    echo "Variáveis de ambiente exportadas com sucesso para o arquivo 'exported_variables.txt'."
}

# Função para importar variáveis de ambiente no Windows
import_windows_variables() {
    if [[ -f "exported_variables.txt" ]]; then
        echo "Importando variáveis de ambiente no Windows..."
        while IFS= read -r line; do
            if [[ "$line" =~ ^[a-zA-Z_][a-zA-Z0-9_]*= ]]; then
                var_name=$(echo "$line" | cut -d '=' -f 1)
                var_value=$(echo "$line" | cut -d '=' -f 2-)
                setx "$var_name" "$var_value" > /dev/null
            fi
        done < exported_variables.txt
        echo "Variáveis de ambiente importadas com sucesso no Windows."
    else
        echo "Arquivo 'exported_variables.txt' não encontrado."
    fi
}

# Função para importar variáveis de ambiente no Linux
import_linux_variables() {
    if [[ -f "exported_variables.txt" ]]; then
        echo "Importando variáveis de ambiente no Linux..."
        while IFS= read -r line; do
            if [[ "$line" =~ ^[a-zA-Z_][a-zA-Z0-9_]*= ]]; then
                var_name=$(echo "$line" | cut -d '=' -f 1)
                var_value=$(echo "$line" | cut -d '=' -f 2-)
                export "$var_name"="$var_value"
            fi
        done < exported_variables.txt
        echo "Variáveis de ambiente importadas com sucesso no Linux."
    else
        echo "Arquivo 'exported_variables.txt' não encontrado."
    fi
}

# Verificar entrada do usuário
read -p "Digite 1 para exportar variáveis de ambiente ou 2 para importar variáveis de ambiente: " choice

# Executar ação com base na escolha do usuário
case $choice in
    1)
        export_variables
    ;;
    2)
        if [[ "$OSTYPE" == "msys" ]]; then
            import_windows_variables
        else
            import_linux_variables
        fi
    ;;
    *)
        echo "Escolha inválida."
    ;;
esac
