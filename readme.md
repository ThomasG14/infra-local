# 🧱 Infra Locale (WSL2 + Docker)

## 🧠 Présentation

Cette infrastructure locale est basée sur :

- WSL2 (Ubuntu)
- Docker + Docker Compose
- Bases de données locales (MySQL, PostgreSQL, Redis)
- Stockage S3 compatible (MinIO)
- Monitoring complet (Prometheus, Grafana, Loki, cAdvisor)

Objectif :
👉 créer une infra locale type “mini cloud” pour développement backend.



# 🧱 Architecture

infra/  
├── core-stack/      
├── db-stack/  
├── monitoring-stack/  
├── .env



# 🌐 Réseau Docker

Tous les services partagent un réseau Docker :

```bash
docker network create infra-net
```

# ⚙️ Variables d’environnement

```env
# MySQL
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=app
MYSQL_USER=dev
MYSQL_PASSWORD=devpass

# Postgres
POSTGRES_DB=app
POSTGRES_USER=dev
POSTGRES_PASSWORD=devpass

# Ports
PORTAINER_PORT=9443
MYSQL_PORT=3306
POSTGRES_PORT=5432
REDIS_PORT=6379
MINIO_API_PORT=9000
MINIO_UI_PORT=9001
```
# 🚀 Lancement de l’infra

lancer le script de start
```bash
./start-infra.sh
```


# 🌍 Accès aux services

### 🧠 Core
- Portainer : https://localhost:9443
- Traefik : http://localhost:8080 <--- disabled comming soon
___
### 🗄️ Bases de données
- MySQL : localhost:3306
- PostgreSQL : localhost:5432
- Redis : localhost:6379
___
### 📦 S3 (MinIO)
- API : http://localhost:9000
- UI : http://localhost:9001
___
### 📊 Monitoring
- Grafana : http://localhost:3000
- Prometheus : http://localhost:9090
- cAdvisor : http://localhost:8081
- Loki : http://localhost:3100
___
### 📊 Monitoring stack
Inclut :
- Grafana (dashboards)
- Prometheus (metrics)
- Loki (logs)
- Promtail (collecte logs Docker)
- cAdvisor (metrics containers)
___
## 🔐 Authentiifications

### Grafana login
- URL : http://localhost:3000/
- User : admin
- Password : admin
___
### S3 login
- URL : http://localhost:9001/
- User : admin
- Password : password123

## 🧠 Architecture logique
- core-stack → infra (Portainer, proxy)
- db-stack → données (DB + S3)
- monitoring-stack → observabilité
____
## 🧰 Commandes utiles
Voir containers
```bash
docker ps
```

Logs
```bash
docker logs <container>
```

Restart infra
```bash
docker compose restart
```

Stop infra
```bash
docker compose down
```