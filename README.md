# 💻 HomeLab: De Laptop Vieja a Servidor Casero

¡Bienvenido al repositorio oficial de la serie! 🚀 

Este proyecto documenta todo el proceso de transformación de una laptop antigua (Lenovo ideapad 100-15IBY) en un servidor casero 100% funcional y automatizado utilizando Ubuntu Server. Aquí encontrarás todos los comandos, scripts y configuraciones que utilizamos a lo largo de los videos para que puedas replicarlo paso a paso.

## 🎯 Objetivo del Proyecto
Darle una segunda vida a hardware antiguo para crear un entorno de servidor eficiente (HomeLab). A lo largo de la serie configuraremos servicios de red, automatización mediante scripts de Bash, gestión de energía y plataformas de auto-alojamiento (self-hosting).

---

## 📺 Índice de Episodios

A continuación, puedes acceder a los comandos y archivos específicos de cada episodio:

### [Episodio 1: Instalación y Preparación Base]
* Descarga de la imagen ISO.
* Flasheo con Rufus.
* Instalación limpia de Ubuntu Server.

### [Episodio 2: Domando el Hardware y Script de Voz](./Episodio_2/)
* Configuración de GRUB (Apagado de pantalla y desactivación de teclado).
* Configuración de `logind` para evitar la suspensión al cerrar la tapa.
* Script en Bash (`bateria_alerta.sh`) para monitoreo de batería y alertas por voz usando la API de Google (gTTS).
* Automatización con Cronjobs.

### [Episodio 3: Servicios y Redes (Próximamente) ⏳]
* Configuración de IP Estática (Netplan).
* Instalación de CasaOS.
* Despliegue de Jellyfin (Media Server).

---

## 🛠️ Tecnologías y Herramientas Utilizadas
* **Sistema Operativo:** Ubuntu Server 
* **Scripting:** Bash, Python
* **Automatización:** Cron
* **Redes:** Netplan, SSH
* **Hardware:** Lenovo ideapad 100-15IBY

---

## 👨‍💻 Sobre el Autor
Soy Edson, estudiante de Ingeniería de Sistemas y un apasionado por la tecnología, los servidores y la automatización. Si te sirvió este proyecto, no olvides suscribirte al canal y dejarle una ⭐ a este repositorio.

🔗 **[Visita mi canal de YouTube y suscríbete aquí](https://www.youtube.com/@EdsonPerez7)**
