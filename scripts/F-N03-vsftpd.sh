#!/bin/bash
# Despliega la configuración de vsftpd de F-N03. Uso: sudo bash scripts/F-N03-vsftpd.sh
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CONF_SRC="$REPO_DIR/config/F-N03/vsftpd.conf"

if [ "$(id -u)" -ne 0 ]; then
  echo "Ejecuta el script con sudo" >&2
  exit 1
fi

command -v vsftpd >/dev/null || apt-get install -y vsftpd

[ -f /etc/vsftpd.conf.bak ] || cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
install -m 644 "$CONF_SRC" /etc/vsftpd.conf
echo bchecker > /etc/vsftpd.userlist

systemctl enable vsftpd
systemctl restart vsftpd

echo "--- Puerto 21 ---"
ss -tlnp | grep ':21' || { echo "vsftpd no escucha en el puerto 21" >&2; exit 1; }
