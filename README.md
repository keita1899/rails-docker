# README
このリポジトリはDocker上でRailsアプリを動かすためのものです。
データベースはPostgresを使用しています。

## 環境構築手順
1. git clone https://github.com/keita1899/rails-docker.git
2. cd rails-docker
3. docker-compose build
4. docker-compose up
5. docker-compose run web rake db:create db:migrate
6. http://localhost:3000 にアクセスしてRailsのページが表示されるか確認