# Taller 1: Introducción a Docker
Bienvenido a este taller básico de Docker, esta divido en varias secciones, para que tengas una introducción rápida al uso de Docker para crear containers.

## Requisitos
Tener una máquina virtual o instancia en cualquier proveedor de nube como Google Cloud, Azure, Amazon o Digital Ocean, o bien una máquina virtual local. De preferencia con Ubuntu 18.04LTS para estandarizar errores a una distribución y dar soporte en el taller.
En este caso utilizaré Digital Ocean.

## Paso 1: Instalar e iniciar Docker
Una vez tienes tu instancia y acceso a SSH de la misma, ingresa a la misma. Ejecuta como root o con permisos de root el siguiente comando, para actualizar los repositorios en la máquina virtual recién creada:
```
apt-get update
```
Luego ejecuta el siguiente comando para instalar Docker 
```
apt-get install docker.io
```
Luego iniciar el servicio si esta apagado con:
```
/etc/init.d/docker start
```
## Paso 2: Bajar imágenes del repositorio de Docker en específico la de Ubuntu 18.04
Para bajar una imagen utilizamos el comando docker pull, en este caso bajaremos la imagen de Ubuntu 18.04 para esto ejecutamos el comando:
```
docker pull ubuntu:18.04
```
Donde ubuntu es el repositorio y el tag a bajar es 18.04, para mayor referencia puedes visitar 
https://hub.docker.com/ y bajar la imagen que necesites con el tag que necesites
## Paso 3: Crear una imagen de Docker
Para crear una imagen debes de utilizar el comando docker run, en este caso crearemos un container con Ubuntu 18.04 y ejecutaremos dentro el comando /bin/bash, el cual es una consola o terminal, nótese que al terminar la ejecución del /bin/bash con exit, el comando con el que fue creado el container termina su ejecución y el container es finalizado con el estado exit(0), finalizado más no eliminado
```
docker run -it ubuntu:18.04 /bin/bash
```
Al ser creado el container creara un id único el cual puedes obtener cuando se coloca el nuevo prompt luego de terminar de ejecutar el comando anterior, veras algo como:
```
root@e6b272bfcbc2:/#
```
Puedes realizar distintas operaciones con este id, regularmente solo necesitaras las primeras 3 o 4 letras del mismo
Continuando, luego ejecutar dentro el comando ls para mostrar los archivos actuales en la carpeta que te encuentres
```
ls
```
En otra terminal ingresa y ejecuta el comando
docker ps -a podrás ver que dicho container se encuentra en estado activo: verás una salida como la siguiente:
```
docker ps -a
```
![Alt text](imgs/ps1.png?raw=true "Up time")

Luego en la línea de comandos del container escribe exit, para salir y finalizar el container
```
exit 
```
Ahora revisa el nuevamente los containers corriendo con:
```
docker ps -a
```
![Alt text](imgs/ps2.png?raw=true "Up time")

Ahora veras que el estado es exit, es decir la ejecución del container finalizo, pero no ha sido destruido
Ahora para volver a iniciar el container ejecuta:
```
docker start id_container
```
Esto reiniciar la ejecución de container con el id que hallas colocado
Ahora para volver a ingresar, puedes ejecutar
```
docker exec -it id_container /bin/bash
```
Y esto ejecutara una nueva consola adicional a la que está ejecutándose por el /bin/bash inicial, y no afectara si la finalizas con exit, el container seguirá ejecutándose.
