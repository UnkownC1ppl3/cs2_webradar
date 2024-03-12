@echo off

start "cs2_webradar - Server" cmd /k "if exist "Server" (echo [cs2_webradar] installing web server dependencies.. && cd "Server" && npm install && echo [cs2_webradar] installed web server dependencies) else (echo "error" && exit /b 1)"
start "cs2_webradar - Web" cmd /k "if exist "Web" (echo [cs2_webradar] installing Web dependencies.. && cd "Web" && npm install && npm audit fix && echo [cs2_webradar] installed Web dependencies) else (echo "error" && exit /b 1)"
