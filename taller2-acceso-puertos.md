# Taller 2: Acceso público de containers
Bienvenido a este taller, en este taller aprenderás como manejar los puertos en los containers y cómo permitir que tengan acceso público a través de los mismos. Esto lo lograremos a través de crear un container con Apache instalado en el puerto 80, el cual saldrá por el puerto 8001 del host que tiene instalado Docker

## Requisitos
- Tener una máquina virtual o instancia en cualquier proveedor de nube como Google Cloud, Azure, Amazon o Digital Ocean, o bien una máquina virtual local. De preferencia con Ubuntu 18.04LTS para estandarizar errores a una distribución y dar soporte en el taller.
En este caso utilizaré Digital Ocean.
- Haber realizado el [Taller 1](taller1-introduccion.md)

## Paso 1: Crear container y exponer los puertos
Luego de haber ingresado a tu máquina virtual con Docker instalado, ejecutar el siguiente comando para crear una máquina virtual con Ubuntu:18.04
```
docker run -it -d -p 8001:80 --name=apache ubuntu:18.04 /bin/bash
```
### Explicación
Este comando lo que hará es que creará un container con la imagen del repositorio de Ubuntu en el DockerHub con su tag 18.04, es decir Ubuntu versión 18.04. En este caso creamos la imagen con el parámetro -d que significa que se ejecute en segundo plano o como daemon, y que exponga los puertos 80 del container con el 8001 del host, luego en vez de acceder al container por su ID, lo accesamos por el nombre "apache" y finalmente se crea el container ejecutando el comando /bin/bash dentro de él.

## Paso 2: Acceder al container que esta en segundo plano
Para acceder al container debes de ejecutar el comando:
```
docker exec -it apache /bin/bash
```
Luego de ingresar al container actualiza el repositorio de ubuntu:
```
apt-get update
```
Luego instala Apache con el siguiente comando:
```
apt-get install apache2
```
Luego inicia apache con el comando
```
/etc/init.d/apache2 start
```
Luego ejecuta exit para salir del container
```
exit
```
## Paso 3: Accede al sitio localizado enlazado al container
Para esto debes de obtener el ip de tu máquina virtual, en este caso el IP público, dependiendo del proveedor puedes verlo con el comando, podría ser la interfaz eth0 en algunos casos:
```
ifconfig -a 
```
y buscar el IP público o bien con el IP público asignado por tu proveedor de la nube, solo debes acceder desde el navegador como
```
http://IP:PORT
```
Para acceder desde el host:
```
http://IP_HOST:8001
```
Para acceder desde el container:
```
http://IP_CONTAINER:80
```
y podrás ver la instalación por defecto de Apache, también puedes usar el puerto 80 en el servidor público, colocando -p 80:80 en vez de -p 8001:80
## Paso 4: Ver IP del container
En algunos casos, como prueba local podrás acceder al IP del container, ya sea desde adentro del mismo con ifconfig o bien con el comando docker en otra consola ejecutando:
```
docker inspect apache | grep IPAddress
```
