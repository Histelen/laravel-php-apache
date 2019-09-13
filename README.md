# laravel-php-apache
Arquivos para leventar container docker para estudo de Laravel framework versão 5.3

A estrutura de diretórios deve ser a seguinte:
Pasta "public" contendo todo o framework do laravel

docker push histelen/laravel-php-apache:tagname

Para criação do projeto rode o containner e entre dentro dele através do bash:
docker exec -it id-do-containner bash

Agora dentro do container rode o comando de instalação da versão 5.x do laravel que desejar:
composer create-project --prefer-dist laravel/laravel blog "5.8.*"

Para configuração do banco de dados MySql use as configurações no .env:
DB_CONNECTION=mysql
DB_HOST=vigiles-db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=root

Em sistema operacional linux ubuntu 18.04 foi necessário dar permissão na pasta "storage"

Para abrir o Laravel no navegador, use o endereço:
http://localhost:8002/
