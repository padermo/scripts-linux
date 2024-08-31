# Instalación de Herramientas de Desarrollo para Linux (Debian)
El contenido del repositorio instala entorno de Node asi mismo la opción de instalación de programas de paqueterias Flatpak o Snap.

## Uso
1. Clonar o descargar el repositorio.
2. Abrir una terminal en la ubicación del repositorio.
3. Ejecutar el archivo **install.sh**
4. Seguir los pasos indicados en la terminal.

El archivo **install.sh** descomprime y ejecuta el contenido de **scripts.tar.gz**

## Explicación de los Scripts
1. El script que primero se ejecuta es **install_dev_tools.sh** el cual proporciona opciones de instalación de: node js, lua, packer, neovim, git, mongodb, curl y finaliza con la opción de instalar programas adicionales probenientes de las paqueterias **Snap** o **Flatpak**

2. El script opcional **install_programs.sh** proporciona opciones como: instalar snap o flatpak, luego provee opciones de instalacion de algunos programas como vscode, brave, firefox, chrome, postman, etc.

## Importante
Ninguno de los scripts realiza o efectua modificaciones al sistema operativo que no hallan sido aceptadas por el usuario que este ejecutando dicho script y todas las instalaciones de programas o herramientas se efectuan de recursos oficiales.
