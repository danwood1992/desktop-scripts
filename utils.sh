LOG_DIR="/var/log/my_dev_setup"
LOG_FILE="$LOG_DIR/utils_setup.log"

check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "Run as root" >&2
    exit 1
  fi
}

setup_logging() {
  mkdir -p "$LOG_DIR"
  chmod 700 "$LOG_DIR"

  touch "$LOG_FILE"
  chmod 600 "$LOG_FILE"
}

handle_error() {
  log_entry "Error on line $1"
  exit 1
}

log_entry() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

check_ubuntu() {
  log_entry "Checking OS..."
  grep -q 'Ubuntu' /etc/os-release || { log_entry "Only for Ubuntu"; exit 1; }
}

check_internet() {
  log_entry "Checking internet connection..."
  wget -q --spider http://google.com || { log_entry "No internet"; exit 1; }
}


update_packages() {
  log_entry "Updating package list and upgrading existing packages..."
  apt update -y && apt upgrade -y
}


