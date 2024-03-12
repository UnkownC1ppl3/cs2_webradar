@echo off
start "cs2_webradar" cmd /k "cd Server && node app.js"
start "cs2_webradar" cmd /k "cd Web && npm run dev"