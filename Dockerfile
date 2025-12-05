# /**
#  * @file: Dockerfile
#  * @description: Docker образ для Caddy SSL сервиса (Timeweb App Platform)
#  * @created: 2025-12-05
#  */

FROM caddy:2.10.2-alpine

# Копируем Caddyfile в образ
COPY Caddyfile /etc/caddy/Caddyfile

# Указываем порт для Timeweb App Platform
EXPOSE 80

# Запуск Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
