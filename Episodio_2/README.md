# 🚀 Episodio 2: Configurando la Laptop Vieja (Tapa, Pantalla y Voz)

En este episodio configuramos nuestra laptop para que funcione como un verdadero servidor "Headless" (sin monitor ni teclado) y le dimos voz para que nos avise si se queda sin batería.

---

## 🛠️ 1. Configurar la Pantalla y Desactivar Teclado (GRUB)

Con esto logramos que la pantalla se apague al minuto de inactividad (ahorrando energía) y desactivamos el teclado roto para evitar falsos contactos.

1. **Abrir el archivo:**
```bash
sudo nano /etc/default/grub
```

2. **Modificar esta línea exacta:**
Busca la línea que empieza con `GRUB_CMDLINE_LINUX_DEFAULT` y déjala así:
```text
GRUB_CMDLINE_LINUX_DEFAULT="consoleblank=60 i8042.nokbd"
```

3. **Aplicar los cambios y reiniciar:**
```bash
sudo update-grub
sudo reboot
```

---

## 🛡️ 2. Ignorar la Tapa (No Suspender)

Para poder cerrar la tapa de la laptop sin que el servidor se apague o pierda la conexión.

1. **Abrir el archivo de energía:**
```bash
sudo nano /etc/systemd/logind.conf
```

2. **Descomentar (quitar el `#`) y modificar estas dos líneas:**
```ini
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
```

3. **Reiniciar el servicio para aplicar:**
```bash
sudo systemctl restart systemd-logind
```

---

## 🤖 3. Hacer que el Servidor Hable (Script de Batería)

**A. Instalar las herramientas necesarias (Lector de batería, reproductor de audio e IA de Google):**
```bash
sudo apt update
sudo apt install acpi mpg123 -y
sudo pip3 install gTTS
```

**B. Crear el Script:**
```bash
nano /home/TU_USUARIO/bateria_alerta.sh
```
*(Nota: Cambia la ruta `/home/TU_USUARIO/` por tu usuario real).*

**C. Pegar el siguiente código:**
```bash
#!/bin/bash

# --- Forzar volumen al 100% ---
amixer set Master 100% unmute > /dev/null 2>&1

# 1. Obtener nivel de batería
BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')

# 2. Obtener estado
STATUS=$(acpi -b | grep -o "Discharging")

# 3. Lógica principal
if [ "$STATUS" == "Discharging" ]; then

    # PRIORIDAD 1: Emergencia (5% o menos)
    if [ "$BATTERY_LEVEL" -le 5 ]; then
        MENSAJE="Tengo $BATTERY_LEVEL por ciento. Me apagaré ahora."
        /usr/local/bin/gtts-cli "$MENSAJE" --lang es | mpg123 -
        sleep 20
        shutdown -h now

    # PRIORIDAD 2: Advertencia (15% o menos)
    elif [ "$BATTERY_LEVEL" -le 15 ]; then
        MENSAJE="Peligro. Tengo $BATTERY_LEVEL por ciento de batería."
        /usr/local/bin/gtts-cli "$MENSAJE" --lang es | mpg123 -
    fi
fi
```

**D. Dar permisos de ejecución al script:**
```bash
chmod +x /home/TU_USUARIO/bateria_alerta.sh
```

---

## ⏱️ 4. Automatizar la revisión (CRONTAB)

Para que el servidor ejecute este script cada 2 minutos.

1. **Abrir el Cron del Administrador:**
```bash
sudo crontab -e
```
*(Si te pide elegir un editor la primera vez, selecciona la opción `nano`).*

2. **Pegar esta línea al final del archivo:**
```text
*/2 * * * * /home/TU_USUARIO/bateria_alerta.sh
```

Guarda con `Ctrl+O`, `Enter`, y sal con `Ctrl+X`. ¡Listo! 🎉
