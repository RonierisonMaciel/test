#!/bin/bash

# Atualizar pacotes e instalar UFW e Nginx
sudo apt update -y
sudo apt install ufw -y
sudo apt install nginx -y
sudo apt install git -y  # Instala o Git para clonar o repositório

# Fazer o clone do seu repositório
cd /var/www/html
sudo git clone https://github.com/RonierisonMaciel/test.git projeto # Substitua pelo seu repositório

# Configurar UFW para permitir tráfego HTTP e HTTPS
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'Nginx HTTPS'
sudo ufw enable

# Configurações básicas do Nginx para servir o projeto
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

# Criar novo arquivo de configuração para o servidor Nginx
sudo tee /etc/nginx/sites-available/default > /dev/null <<EOL
server {
    listen 80;
    server_name _;

    # Servir a página index.html do projeto clonado
    location / {
        root /var/www/html/projeto;  # Caminho do projeto clonado
        index index.html;
    }

    # Servir arquivos estáticos como p1.txt dentro do caminho /static/
    location /static/ {
        alias /var/www/html/projeto/static/;
        autoindex on;
    }

    # Configuração de logs de erro e acessos
    error_log /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
}
EOL

# Reiniciar o Nginx para aplicar as mudanças
sudo systemctl restart nginx

# Verificar status do Nginx
sudo systemctl status nginx
