#!/usr/bin/env bash
set -euo pipefail
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/common.sh
source "$APP_DIR/lib/common.sh"

VENV_DIR="$APP_DIR/.venv"
PORT="${PORT:-5000}"

log_info "[1/5] Memeriksa prasyarat..."
require_cmd python3
require_cmd curl
port_is_free "$PORT" || die "port $PORT sudah dipakai proses lain"

log_info "[2/5] Menyiapkan virtual environment..."
if [[ ! -d "$VENV_DIR" ]]; then
  python3 -m venv "$VENV_DIR"
  log_info "Virtual environment dibuat di $VENV_DIR"
else
  log_info "Virtual environment sudah ada, dilewati."
fi

# shellcheck source=/dev/null
source "$VENV_DIR/bin/activate"

log_info "[3/5] Menginstal dependensi..."
pip install --quiet --upgrade pip
pip install --quiet -r "$APP_DIR/requirements.txt"

log_info "[4/5] Menjalankan aplikasi pada port $PORT..."
BUILD_ID="${BUILD_ID:-dev-local}" python3 "$APP_DIR/src/app.py" &
APP_PID=$!
log_info "Aplikasi berjalan dengan PID $APP_PID"

sleep 2

log_info "[5/5] Memverifikasi endpoint kesehatan..."
if curl -sf "http://127.0.0.1:${PORT}/health" > /dev/null; then
  log_info "Aplikasi sehat dan merespons di http://127.0.0.1:${PORT}/"
else
  log_warn "Aplikasi belum merespons pada endpoint /health"
fi

wait "$APP_PID"
