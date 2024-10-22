# mover-respaldos-de-SQL-y-subirlos-a-Google-Drive
Script para mover respaldos de SQL y subirlos a Google Drive, con notificación por correo.
# Script de Respaldo de SQL y Notificación por Correo

Este proyecto es un script en PowerShell que automatiza el movimiento de archivos de respaldo de SQL desde una unidad local a otra, y luego los sube a Google Drive utilizando `rclone`. El script también envía notificaciones por correo, informando si la operación fue exitosa o si ocurrió algún error.

## Requisitos

- PowerShell
- rclone configurado para Google Drive
- Servidor SMTP configurado para envío de correos (por ejemplo, Gmail)

## Instalación

1. Clonar este repositorio:
   ```bash
   git clone https://github.com/tuusuario/nombre-repositorio.git
