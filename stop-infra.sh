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
echo "             🛑 LOCAL INFRA STOPPER 🛑            "
echo "=================================================="
echo -e "${RESET}"

echo ""

# =========================================
# Stop CORE stack
# =========================================

log "Stopping CORE stack..."

docker compose \
  --env-file .env \
  -f core-stack/docker-compose.yml \
  down

success "CORE stack stopped"

echo ""

# =========================================
# Stop DB stack
# =========================================

log "Stopping DB stack..."

docker compose \
  --env-file .env \
  -f db-stack/docker-compose.yml \
  down

success "DB stack stopped"

echo ""

# =========================================
# Stop MONITORING stack
# =========================================

log "Stopping MONITORING stack..."

docker compose \
  -f monitoring-stack/docker-compose.yml \
  down

success "MONITORING stack stopped"

echo ""

# =========================================
# Optional network cleanup
# =========================================

log "Checking infra network..."

if docker network inspect infra-net >/dev/null 2>&1; then
  docker network rm infra-net >/dev/null 2>&1 || true
  success "infra-net removed"
else
  warning "infra-net already removed"
fi

echo ""

# =========================================
# Final status
# =========================================

echo -e "${BLUE}==================================================${RESET}"
echo -e "${GREEN}✅ INFRA FULLY STOPPED${RESET}"
echo -e "${BLUE}==================================================${RESET}"

echo ""

docker ps --format "table {{.Names}}\t{{.Status}}" || true

echo ""
success "All stacks are down 💤"