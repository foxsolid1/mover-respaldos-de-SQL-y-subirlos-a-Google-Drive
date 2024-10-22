<#
.SYNOPSIS
    Script para mover respaldos de SQL y subirlos a Google Drive, con notificación por correo.

.DESCRIPTION
    Este script automatiza el proceso de mover archivos de respaldo de SQL Server desde una unidad local a otra,
    y luego sube esos archivos a Google Drive utilizando rclone. Además, envía una notificación por correo 
    para informar si el proceso fue exitoso o si ocurrió algún error.

.PARAMETER $smtpServer
    El servidor SMTP para el envío de correos.

.PARAMETER $smtpUser
    Correo electrónico utilizado para enviar las notificaciones.

.PARAMETER $smtpPass
    Contraseña o App Password del correo emisor.

.EXAMPLE
    Para ejecutarlo de forma manual:
    PS C:\> .\moverrespaldos.ps1

.NOTES
    Autor: Gabino Trejo
    Fecha: 22 de Octubre de 2024
    Contacto:foxsolid22df@gmail.com
    Repositorio: https://github.com/foxsolid1?tab=repositories
#>

# Definir las variables de correo
$smtpServer = "smtp.gmail.com"
$smtpPort = 587
$smtpUser = "tu_correo@gmail.com"
$smtpPass = "tu_contraseña"
$from = "tu_correo@gmail.com"
$to = "correo_destinatario@dominio.com"

# Función para enviar notificación
function Enviar-Notificacion {
    param (
        [string]$asunto,
        [string]$mensaje
    )
    
    Send-MailMessage -From $from -To $to -Subject $asunto -Body $mensaje -SmtpServer $smtpServer -Port $smtpPort -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $smtpUser, (ConvertTo-SecureString $smtpPass -AsPlainText -Force))
}

try {
    # Definir las carpetas origen y destino para Carpeta de origen
    $origenDiff1 = "C:\Ruta\Carpeta1"
    $origenFull1 = "C:\Ruta\Carpeta2"
    $destinoDiff1 = "J:\Respaldo"
    $destinoFull1 = "J:\Respaldo"

    # Definir las carpetas origen y destino para Carpeta de origen
    $origenFull2 = "C:\Ruta\Carpeta1"
    $origenInc2 = "C:\Ruta\Carpeta2"
    $destinoFull2 = "J:\Respaldo"
    $destinoInc2 = "J:\Respaldo"

    # Mover los archivos de ORIGEN al destino
    Get-ChildItem -Path $origenDiff1 -Filter "*.bak" | Move-Item -Destination $destinoDiff1

    # Mover los archivos de ORIGEN al destino
    Get-ChildItem -Path $origenFull1 -Filter "*.bak" | Move-Item -Destination $destinoFull1

    # Mover los archivos de ORIGEN al destino
    Get-ChildItem -Path $origenFull2 -Filter "*.bak" | Move-Item -Destination $destinoFull2

    # Mover los archivos de ORIGEN al destino
    Get-ChildItem -Path $origenInc2 -Filter "*.bak" | Move-Item -Destination $destinoInc2

    # Si todo salió bien, enviar notificación de éxito
    Enviar-Notificacion -asunto "Respaldo Completado" -mensaje "Los respaldos se han movido exitosamente."
}
catch {
    # Enviar notificación en caso de error
    Enviar-Notificacion -asunto "Error en Respaldo" -mensaje "Hubo un error al mover los respaldos: $($_.Exception.Message)"
}
