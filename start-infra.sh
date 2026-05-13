#!/bin/bash

set -e

# =========================================
# Colors
# =========================================

GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
RED="\e[31m"
CYAN="\e[36m"
RESET="\e[0m"

# =========================================
# Helpers
# =========================================

log() {
  echo -e "${CYAN}[$(date +'%H:%M:%S')]${RESET} $1"
}

success() {
  echo -e "${GREEN}✔ $1${RESET}"
}

warning() {
  echo -e "${YELLOW}⚠ $1${RESET}"
}

error() {
  echo -e "${RED}✖ $1${RESET}"
}

# =========================================
# Banner
# =========================================

clear

echo -e "${BLUE}"
echo "=================================================="
echo "            🚀 LOCAL INFRA STARTER 🚀             "
echo "=================================================="
echo -e "${RESET}"

# =========================================
# Network
# =========================================

log "Checking Docker network..."

if docker network inspect infra-net >/dev/null 2>&1; then
  warning "infra-net already exists"
else
  docker network create infra-net >/dev/null
  success "infra-net created"
fi

echo ""

# =========================================
# CORE STACK
# =========================================

log "Starting CORE stack..."

docker compose \
  --env-file .env \
  -f core-stack/docker-compose.yml \
  up -d

success "CORE stack started"

echo ""

# =========================================
# DB STACK
# =========================================

log "Starting DB stack..."

docker compose \
  --env-file .env \
  -f db-stack/docker-compose.yml \
  up -d

success "DB stack started"

echo ""

# =========================================
# MONITORING STACK
# =========================================

log "Starting MONITORING stack..."

docker compose \
  --env-file .env \
  -f monitoring-stack/docker-compose.yml \
  up -d

success "MONITORING stack started"

echo ""

# =========================================
# Containers Status
# =========================================

log "Containers status"

docker ps \
  --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""

# =========================================
# URLs
# =========================================

echo -e "${BLUE}==================================================${RESET}"
echo -e "${GREEN}✅ INFRA FULLY STARTED${RESET}"
echo -e "${BLUE}==================================================${RESET}"

echo ""
echo -e "${CYAN}🌐 Services${RESET}"
echo ""

echo "🧠 Portainer    → https://localhost:9443"
echo "📊 Grafana      → http://localhost:3000"
echo "📈 Prometheus   → http://localhost:9090"
echo "📦 MinIO        → http://localhost:9001"
echo "📊 cAdvisor     → http://localhost:8081"
echo "🗄️ MySQL        → localhost:3306"
echo "🐘 PostgreSQL   → localhost:5432"
echo "⚡ Redis        → localhost:6379"
echo "🌿 mongoDB      → localhost:27017"

echo ""
success "Everything is operational 🚀"