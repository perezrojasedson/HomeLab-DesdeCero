# Episodio 3: Redes y Servicios (IP Estática y CasaOS)

En este episodio preparamos nuestra laptop para alojar servicios de forma permanente. Para evitar perder el acceso al servidor cada vez que se reinicie el router, configuramos una IP estática usando Netplan. Finalmente, instalamos CasaOS, un sistema de gestión visual que transformará nuestra terminal en un panel de control moderno e intuitivo.

---

## 1. Identificar la Configuración Actual de Red

Antes de asignar una IP estática, necesitamos conocer el nombre de nuestra interfaz de red y la dirección IP de nuestro router (Gateway).

**Ver las interfaces y tu IP actual:**
```bash
ip -br a
```
Anota el nombre de la interfaz que dice `UP` (ej. `enp3s0` para cable o `wlp4s0` para Wi-Fi).

**Ver la dirección del router (Gateway):**
```bash
ip route | grep default
```
*Nota técnica:* Si en el resultado ves la frase `proto dhcp`, significa que tu IP es dinámica y puede cambiar. Nuestro objetivo es que al finalizar este tutorial, el resultado muestre `proto static`, confirmando que la dirección IP ha quedado fijada.

---

## 2. Configurar la IP Estática (Netplan)

Ubuntu Server utiliza Netplan para gestionar las redes mediante archivos YAML. Vamos a crear un archivo de configuración que permita fijar la IP, ya sea por cable o por Wi-Fi.

**Abrir el editor de texto:**
```bash
sudo nano /etc/netplan/99-static-ip.yaml
```

**Pegar la siguiente configuración:**
*(Atención: La sintaxis YAML es estricta. Usa espacios en lugar de tabuladores y reemplaza los valores por los de tu red).*

```yaml
network:
  version: 2
  renderer: networkd
  
  # --- CONFIGURACIÓN PARA CABLE (Recomendado) ---
  ethernets:
    enp3s0:              # <-- CAMBIAR por el nombre de tu interfaz de cable
      dhcp4: false
      optional: true     # Evita que el servidor se congele al arrancar si el cable está desconectado
      addresses:
        - 192.168.0.50/24  # <-- Tu IP estática deseada
      routes:
        - to: default
          via: 192.168.0.1 # <-- IP de tu router
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]

  # --- CONFIGURACIÓN PARA WI-FI (Respaldo) ---
  wifis:
    wlp4s0:              # <-- CAMBIAR por el nombre de tu interfaz Wi-Fi
      dhcp4: false
      optional: true     # Permite que el sistema inicie rápido cuando no este cableado
      access-points:
        "WiFi - Fracy":  # <-- Mantén las comillas
          password: "TU_CONTRASEÑA_SECRETA" # <-- Mantén las comillas
      addresses:
        - 192.168.0.114/24  # <-- IP estática deseada para el Wi-Fi
      routes:
        - to: default
          via: 192.168.0.1 # <-- IP de tu router
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
```
Guarda los cambios con `Ctrl+O`, presiona `Enter`, y sal con `Ctrl+X`.

---

## 3. Aplicar los Cambios de Red (El Salvavidas)

Para evitar perder la conexión con nuestro servidor si cometimos un error de sintaxis en el archivo YAML, utilizaremos el comando de prueba:

```bash
sudo netplan try
```
*Nota técnica:* Este comando aplica la configuración y arranca un contador de 120 segundos. Si pierdes la conexión por un error, Netplan revertirá los cambios automáticamente al llegar a cero, salvando tu acceso. Si la conexión se mantiene estable, simplemente presiona `ENTER` para confirmar y fijar los cambios.

*(Alternativa: Si estás conectado físicamente al servidor y seguro de tu configuración, puedes usar `sudo netplan apply` para aplicar los cambios de golpe).*

---

## 4. Instalación de CasaOS

Con nuestra IP estática configurada, el servidor ya no cambiará de dirección. Ahora instalaremos CasaOS, un sistema de nube personal basado en Docker que facilita la instalación de aplicaciones con un solo clic.

**Ejecutar el script de instalación oficial:**
```bash
curl -fsSL [https://get.casaos.io](https://get.casaos.io) | sudo bash
```
La instalación tomará unos minutos dependiendo de la velocidad de tu conexión a internet y el hardware.

---

## 5. Acceso al Panel de Control

Una vez finalizada la instalación de CasaOS, la administración por terminal pasa a un segundo plano.

1. Abre un navegador web desde cualquier dispositivo conectado a tu red local.
2. Ingresa en la barra de direcciones la IP estática que configuraste en el paso 2 (ej. `http://192.168.0.114`).
3. Crea tu cuenta de administrador en la pantalla de bienvenida y disfruta de tu nuevo entorno gráfico.
