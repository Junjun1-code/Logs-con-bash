#! /bin/bash

## Creación de directorio
mkdir -p Logs_Script
echo "Creando registros dentro de la carpeta Logs_Script"

## Extraccion de IP:

ip addr show > ./Logs_Script/ip

## Extracción de usuarios
echo "Conectados:" > ./Logs_Script/users
who >> ./Logs_Script/users
echo "-------------------------" >> ./Logs_Script/users
printf "\nRegistrados en sistema:" >> ./Logs_Script/users
cat /etc/passwd >> ./Logs_Script/users
echo "-------------------------" >> ./Logs_Script/users
printf "\nUltimo inicio de sesión" >> ./Logs_Script/users
lastlog >> ./Logs_Script/users

## Fallos en inicio de sesion
printf "\nFallos de inicio de sesion" >> ./Logs_Script/users.fail
sort /var/log/auth.log  | grep -c "Invalid user" >> ./Logs_Script/users.fail
sort /var/log/auth.log  | grep -c "Failed password" >> ./Logs_Script/users.fail

printf "\nInicios y cierres de sesiones" >> ./Logs_Script/users.success
sort /var/log/auth.log | uniq -c | grep "session opened | session closed" >> ./Logs_Script/users.success
