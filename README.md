# SSL-Certificates-API

Сервис автоматического создания и продления SSL сертификатов для проектов на [Timeweb Cloud](https://timeweb.cloud/).

## 🚀 Быстрый старт

### Требования

- Docker 20.10+
- Docker Compose 2.0+
- Открытые порты 80 и 443

### Установка

```bash
# 1. Клонировать репозиторий
git clone <repository-url>
cd SSL-Certificates-API

# 2. Создать .env файл
cp env.example .env

# 3. Запустить сервис
docker compose up -d

# 4. Проверить статус
docker compose ps
docker compose logs -f caddy
```

## 📋 Конфигурация доменов

Текущие настроенные домены:

| Домен | Backend IP | Статус |
|-------|------------|--------|
| dimbopizza.ru | 2.59.42.195 | ✅ |
| antaliya.volzhck.ru | 31.130.147.150 | ✅ |
| api.volzhck.ru | 31.130.147.150 | ✅ |
| dimbo.volzhck.ru | 31.130.147.150 | ✅ |
| dodopizza.volzhck.ru | 31.130.147.150 | ✅ |

### Добавление нового домена

1. Добавьте A-запись в DNS, указывающую на IP сервера с Caddy
2. Добавьте блок в `Caddyfile`:

```caddyfile
your-domain.ru {
    import security_headers
    import compression
    import access_log
    
    reverse_proxy http://BACKEND_IP:80 {
        header_up Host {host}
        header_up X-Real-IP {remote_host}
        header_up X-Forwarded-For {remote_host}
        header_up X-Forwarded-Proto {scheme}
    }
}
```

3. Перезапустите Caddy:

```bash
docker compose restart caddy
```

## 🔧 Команды

```bash
# Запуск
docker compose up -d

# Остановка
docker compose down

# Просмотр логов
docker compose logs -f caddy

# Проверка конфигурации
docker compose exec caddy caddy validate --config /etc/caddy/Caddyfile

# Перезагрузка конфигурации (без даунтайма)
docker compose exec caddy caddy reload --config /etc/caddy/Caddyfile
```

## 📁 Структура проекта

```
SSL-Certificates-API/
├── docker-compose.yml    # Docker конфигурация
├── Caddyfile             # Конфигурация Caddy
├── env.example           # Пример переменных окружения
├── .gitignore            # Исключения Git
├── README.md             # Этот файл
└── docs/
    ├── Project.md        # Архитектура проекта
    ├── Tasktracker.md    # Трекер задач
    ├── Diary.md          # Дневник разработки
    └── qa.md             # Вопросы и ответы
```

## 🔒 Безопасность

- Автоматический HTTPS через Let's Encrypt
- TLS 1.2+ (рекомендуется TLS 1.3)
- HSTS headers включены
- Автоматическое продление сертификатов

## 📖 Документация

- [Архитектура проекта](docs/Project.md)
- [Трекер задач](docs/Tasktracker.md)
- [Дневник разработки](docs/Diary.md)
- [Caddy Documentation](https://caddyserver.com/docs/)

## 📧 Контакты

**Email:** baganov.v@gmail.com

---

*Powered by [Caddy](https://caddyserver.com/) + [Let's Encrypt](https://letsencrypt.org/)*
