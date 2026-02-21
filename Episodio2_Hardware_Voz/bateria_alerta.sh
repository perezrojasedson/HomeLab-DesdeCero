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
        MENSAJE="Edson, cárgame. Tengo $BATTERY_LEVEL por ciento de batería."
        /usr/local/bin/gtts-cli "$MENSAJE" --lang es | mpg123 -
    fi
fi
