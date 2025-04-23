#!/bin/bash

set -e

# Variables
INSTALL_DIR="/opt/locksafe"
DESKTOP_FILE="$HOME/Desktop/LockSafe.desktop"
ICON_PATH="$INSTALL_DIR/locksafe.jpeg"

# Function to print messages
echo_info() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}

# 1. Check and install dependencies
echo_info "Checking for dependencies..."

if ! command -v cryptsetup &> /dev/null; then
  echo_info "cryptsetup not found. Installing..."
  sudo apt install -y cryptsetup
fi

if ! command -v zenity &> /dev/null; then
  echo_info "zenity not found. Installing..."
  sudo apt install -y zenity
fi

# 2. Create install directory
if [ ! -d "$INSTALL_DIR" ]; then
  echo_info "Creating install directory at $INSTALL_DIR"
  sudo mkdir -p "$INSTALL_DIR"
fi

# 3. Copy script and icon
SCRIPT_PATH="$(dirname "$0")/locksafe.sh"
ICON_SOURCE="$(dirname "$0")/locksafe.jpeg"

echo_info "Copying script and icon to $INSTALL_DIR"
sudo cp "$SCRIPT_PATH" "$INSTALL_DIR/locksafe.sh"
sudo cp "$ICON_SOURCE" "$ICON_PATH"
sudo chmod +x "$INSTALL_DIR/locksafe.sh"

# 4. Create desktop launcher
echo_info "Creating desktop launcher at $DESKTOP_FILE"

cat > "$DESKTOP_FILE" <<EOL
[Desktop Entry]
Name=LockSafe
Comment=Securely lock and unlock your safe
Exec=bash -c '"$INSTALL_DIR/locksafe.sh"'
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Utility;
EOL

chmod +x "$DESKTOP_FILE"

# 5. Done
echo_info "Installation complete. You can now use LockSafe from your desktop."
zenity --info --text="LockSafe installed successfully! You can now use it from your desktop."
