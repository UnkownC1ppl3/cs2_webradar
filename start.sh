#!/bin/bash

# Function to start the server application
start_server() {
    cd Server && node app.js
}

# Function to start the web development server
start_web_dev() {
    cd Web && npm run dev
}

# Start both the server application and the web development server in the background
start_server &
start_web_dev &
wait
