#!/bin/bash

# Function to install server dependencies
install_server_dependencies() {
    if [ -d "Server" ]; then
        echo "[cs2_webradar] Installing web server dependencies.."
        cd "Server" && npm install
        echo "[cs2_webradar] Installed web server dependencies."
    else
        echo "Error: Server directory does not exist."
        exit 1
    fi
}

# Function to install web dependencies
install_web_dependencies() {
    if [ -d "Web" ]; then
        echo "[cs2_webradar] Installing Web dependencies.."
        cd "Web" && npm install && npm audit fix
        echo "[cs2_webradar] Installed Web dependencies."
    else
        echo "Error: Web directory does not exist."
        exit 1
    fi
}

# Running both installations in the background
install_server_dependencies &
install_web_dependencies &
wait
