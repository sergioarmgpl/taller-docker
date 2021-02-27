# Taller 3: Creación de imágenes de containers con Dockerfiles  
Bienvenido a este taller, en este taller aprenderás a crear tu propia image de Docker y subirla a tu repositorio [Docker Hub](https://hub.docker.com/), luego crearás tu container a partir de esta nueva imagen que creaste y le permitirás que tengan acceso público a través de los puertos. Esto lo lograremos a través de crear un container con Apache instalado en el puerto 80, el cual saldrá por el puerto 8888 del host que tiene instalado Docker

## Requisitos
- Haber realizado el [Taller 2](taller2-acceso-puertos.md)
- Tener un usuario creado en [Docker Hub](https://hub.docker.com/), recordar bien usuario y contraseña

## Paso 1: Crear el archivo Dockerfile e index.html
Debes de crear un Dockerfile e index.html con tu editor de línea de comandos favorito o bien clonar este repositorio y ubicarte en la carpeta taller3-source

Primero debes crear el archivo llamado "Dockerfile" con el siguiente contenido:
```
FROM ubuntu:18.04
MAINTAINER CloudNativePlusGT
RUN apt-get update
RUN apt-get install -y apache2
RUN rm /var/www/html/*
COPY index.html /var/www/html/
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
```

Seguidamente debes crear el archivo "index.html" con una línea de texto
```
Funcionó la creación de tu primer container con <b>Dockerfiles</b>
```

### Explicación
A continuación esta la explicación de cada una de las líneas del Dockerfile
FROM indica que se descargará la imagen de ubuntu con el tag 18.04
MAINTAINER Indica el nombre del creador del container
RUN apt-get update actualiza los repositorios de la imagen descargada
RUN apt-get install apache2 instala apache2 en la imagen
RUN rm /var/www/html/*  borra cualquier contenido dentrol del container en la carpeta /var/www/html
COPY index.html /var/www/html/ copia el archivo index.html dentro del container en la carpeta /var/www/html
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]  define el comando que se ejecutará dentro del container con docker run
EXPOSE 80  El puerto que expone del container será el 80


## Paso 2: Construir imagen y subirla a DockerHub para que sea pública
Para poder construir una imagen a partir de un Dockerfile, primero debemos ubicarnos en la carpeta que tiene el Dockerfile en este caso taller3-source, luego ejecutamos los siguientes comandos:

En caso de no tener cuenta de docker hub, acceda a [Docker Hub](https://hub.docker.com/) y cree una.

Primero nos logueamos con docker login, ingresando nuestro usuario y contraseña creados en el DockerHub:
```
docker login 
```

Luego ejecutamos como root el comando docker build para construir la imagen, en esta caso si utilizamos docker images nos mostrará que se acaba de crear una imagen llamada apache, si deseamos borrarla y no esta en uso podemos utilizar el comando docker rmi, si esta en uso debemos borrar los containers asociados a esa imagen
```
docker build -t apache .
```

Luego tagueamos la imagen local apache con nuestro usuario y el repositorio llamado apache(usuarioDockerHub/apache)
```
docker tag apache usuarioDockerHub/apache
```

Ahora subimos la imagen al repositorio
```
docker push usuarioDockerHub/apache
```

Si deseas puedes usar el script build.sh dandole permisos de ejecución al mismo, ejecutandoló y mandando de parámetro el nombre del usuario del DockerHub(Debes estar en la carpeta del Dockerfile)
```
chmod 777 build.sh
./build usuarioDockerHub
```

## Paso 3: Utiliza la imagen creada
En dado caso la imagen sea privada debes de logearte con el usuario correspondiente para poder descargarla. Para poder usarla ejecutarás el siguiente comando:

```
docker run -it -d -p 8888:80 --name=apacheNuevo usuarioDockerHub/apache
```

Ahora la imagen ya esta ejecutándose

## Paso 4: Monitoreo
Para monitorear tu container puedes ejecutar el siguiente comando:

```
docker stats apacheNuevo
```
Presiona Ctrl+C para cancelar el monitoreo del container

No olvides detener una imagen sino la estas utilizando.
