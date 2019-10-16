# Taller 2: Acceso público de containers
Bienvenido a este taller, en este taller aprenderás como manejar los puertos en los containers y cómo permitir que tengan acceso público a través de los mismos. Esto lo lograremos a través de crear un container con Apache instalado en el puerto 80, el cual saldrá por el puerto 80 del host que tiene instalado Docker

## Requisitos
- Tener una máquina virtual o instancia en cualquier proveedor de nube como Google Cloud, Azure, Amazon o Digital Ocean, o bien una máquina virtual local. De preferencia con Ubuntu 18.04LTS para estandarizar errores a una distribución y dar soporte en el taller.
En este caso utilizaré Digital Ocean.
- Haber realizado el [Taller 1](taller1-introduccion.md)

## Paso 1: Crear container y exponer los puertos
Luego de haber ingresado a tu máquina virtual con Docker instalado, ejecutar el siguiente comando para crear una máquina virtual con Ubuntu:18.04
```
docker run -it -d ubuntu:18.04 -p 80:80 /bin/bash
```
### explicación
Este comando lo que hará es que creará un container con la imagen del repositorio de Ubuntu en el DockerHub con su tag 18.04, es decir Ubuntu versión 18.04. En este caso creamos la imagen con el parámetro -d que significa que se ejecute en segundo plano o como daemon, y que exponga los puertos 80 del container con el 80 del host, y finalmente se cree ejecutando el comando /bin/bash


