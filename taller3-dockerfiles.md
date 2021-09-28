# Taller 3: Creación de imágenes de containers con Dockerfiles  
Bienvenido a este nuevo taller, en esta oportunidad aprenderás a crear tu propia imagen de Docker y subirla a tu repositorio [Docker Hub](https://hub.docker.com/), despues crearás un container, en base a la imagen que creaste anteriormente y al ejecutarse le permitirás que tengan acceso público a través de los puertos. 

Para dicho taller se usara una imagen de Apache en el puerto 80 , el cual saldrá del contendor por el puerto 8888. 

## Requisitos
- Haber realizado el [Taller 2](taller2-acceso-puertos.md)

- Una cuenta en [Docker Hub](https://hub.docker.com/), como recomendacion: recordar bien usuario y contraseña, porque sera de utilidad en los siguientes pasos.

  

## Paso 1: Crear Dockerfile

- [Opcion 1: Crear un archivo Dockerfile y un archivo html](#Opcion1)
- [Opcion 2: Clonar repositorio](#Opcion2)

### Opcion1  

Dentro de una carpeta crear los siguientes archivos

- Dockerfile
- index.html

Contenido del archivo /index.html

```html
<h1>taller-docker</h1>
Exito al crear mi primer container con <b>Dockerfiles</b>!
```

Contenido del archivo /Dockerfile

```dockerfile
FROM ubuntu:18.04
MAINTAINER CloudNativePlusGT
RUN apt-get update
RUN apt-get install -y apache2
RUN rm /var/www/html/*
COPY index.html /var/www/html/
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
```

Donde: 

| Comando                           | Breve descripción                                            |
| --------------------------------- | ------------------------------------------------------------ |
| ```FROM```                        | Indicar que se descargará la imagen de ubuntu con el tag 18.04 |
| ```MAINTAINER```                  | Indica el nombre del creador del container                   |
| ```RUN apt-get update```          | Actualiza los repositorios de la imagen descargada           |
| ```RUN apt-get install apache2``` | Instala apache2 en la imagen                                 |
| ```RUN rm /var/www/html/*  ```    | Borra cualquier contenido dentrol del container en la carpeta /var/www/html |
| ```COPY ```                       | Copia el archivo index.html que se creo hace un momento y colocarlo dentro del container en la ruta /var/www/html |
| ```CMD```                         | Define el comando que se ejecutará dentro del container.     |
| ```EXPOSE ```                     | Define el puerto que expone del container será el 80         |



### Opcion2

Clonar este repositorio y hubicarte dentro de la carpet [taller3-source/](taller3-source)




## Paso 2: Construir imagen y subirla a DockerHub
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
