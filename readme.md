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
# PORTAINER
PORTAINER_PORT=9443

# TRAEFIK
TRAEFIK_PORT1=80
TRAEFIK_PORT2=8080

# MYSQL
MYSQL_PORT=3306
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=app
MYSQL_USER=dev
MYSQL_PASSWORD=devpass

# POSTGRES
POSTGRES_PORT=5432
POSTGRES_DB=app
POSTGRES_USER=dev
POSTGRES_PASSWORD=devpass

# REDIS
REDIS_PORT=6379

# MINIO S3
MINIO_API_PORT=9000
MINIO_UI_PORT=9001
MINIO_ROOT_USER=admin
MINIO_ROOT_PASSWORD=password123

# MONGODB
MONGODB_PORT=27017
MONGODB_USER=admin
MONGODB_PASSWORD=password123

 # GRAFANA
 GRAFANA_PORT=3000
 GRAFANA_USER=admin
 GRAFANA_PASSWORD=admin

# PROMETHEUS
PROMETHEUS_PORT=9090

# LOKI
LOKI_PORT=3100

# CADVISOR
CADVISOR_PORT=8081

# NODE-EXPORTER
NODE_EXPORTER_PORT=9100
```
# 🚀 Lancement de l’infra

lancer le script de start
```bash
./start-infra.sh
```

il est possible de stopper toute l'infra grâce à ce script:
```bash
./stop-infra.sh
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
- MongoDB: localhost:27017
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