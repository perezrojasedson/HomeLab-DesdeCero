# Episodio 1: Preparación e Instalación de Ubuntu Server

En este primer episodio preparamos nuestra laptop antigua para convertirla en la base de nuestro HomeLab. Para lograr un sistema ligero y enfocado puramente en servicios, instalamos Ubuntu Server, el cual no cuenta con interfaz gráfica (GUI) y se administra totalmente por terminal.

A continuación, se detallan los recursos y pasos clave vistos en el video.

---

## 1. Requisitos Previos

Antes de comenzar la instalación en la laptop, necesitas preparar los siguientes elementos desde otra computadora:

* **Unidad USB:** Un pendrive de al menos 4GB de capacidad (toda la información en él será borrada).
* **Imagen ISO:** Descargar la versión más reciente de [Ubuntu Server](https://ubuntu.com/download/server) (versión LTS recomendada para mayor estabilidad).
* **Software de Flasheo:** Descargar [Rufus](https://rufus.ie/) (para Windows) para crear la unidad de arranque.

---

## 2. Creación del USB Booteable con Rufus

1. Conecta tu unidad USB y abre Rufus.
2. En "Dispositivo", selecciona tu USB.
3. En "Elección de arranque", haz clic en "Seleccionar" y busca el archivo ISO de Ubuntu Server que descargaste.
4. El "Esquema de partición" generalmente debe quedar en **GPT** y el "Sistema de destino" en **UEFI (no CSM)** para laptops modernas o relativamente recientes.
5. Haz clic en "Empezar" y acepta las advertencias sobre el borrado de datos.

---

## 3. Proceso de Instalación (Pasos Críticos)

Una vez que insertes el USB en la laptop y arranques desde él (usualmente presionando F2, F12, o Supr al encender), sigue el asistente de instalación.

Asegúrate de prestar especial atención a estos pasos mostrados en el video:

* **Configuración de Red:** Por ahora, deja que el sistema asigne una dirección IP automáticamente (DHCP). La configuración de la IP estática la realizaremos en el Episodio 3.
* **Almacenamiento (Storage):** Si vas a dedicar esta laptop exclusivamente a servidor, selecciona la opción para usar el disco entero (Use an entire disk) y desmarca la opción de configurar como un grupo LVM si buscas una instalación más sencilla.
* **Configuración de Perfil:** Define el nombre de tu servidor, tu usuario y una contraseña segura. Estos serán tus datos de acceso principales.

### Activación de SSH (Paso Obligatorio)

Casi al final del proceso de instalación, el asistente te preguntará si deseas instalar el servidor OpenSSH (Install OpenSSH server).
**Debes marcar esta casilla con la barra espaciadora.** Esto es vital para un servidor "Headless", ya que nos permitirá conectarnos y administrar la laptop desde nuestra computadora principal sin necesidad de tenerle un monitor o teclado conectado físicamente.

---

## 4. Primer Inicio y Actualización

Una vez finalizada la instalación y reiniciado el equipo, retira el USB. Ingresa con el usuario y contraseña que creaste.

El primer paso obligatorio en todo servidor nuevo es actualizar la lista de paquetes y el sistema operativo. Ejecuta el siguiente comando:

```bash
sudo apt update && sudo apt upgrade -y
