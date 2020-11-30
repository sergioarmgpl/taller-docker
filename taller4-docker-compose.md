# Taller 4: Uso de Docker Compose
Bienvenido a este taller, en el cual aprenderás a utilizar Docker Compose, para orquestar de forma local container, y crear un ambiente de pruebas para agrupar microservicios a través de un archivo de configuración, el cual te permite administrar totalmente un grupo de servicios, siendo útil para pruebas en ambientes de desarrollo y un paso previo a desplegar una solución en un cluster de Kubernetes.

## Requisitos
- Haber realizado el [Taller 3](taller3-dockerfiles.md)
Tener una máquina virtual o instancia en cualquier proveedor de nube como Google Cloud, Azure, Amazon o Digital Ocean, o bien una máquina virtual local. De preferencia con Ubuntu 18.04LTS para estandarizar errores a una distribución y dar soporte en el taller.

## Paso 1: Descargar Docker Compose e instalarlo
Para poder descargar Docker Compose debes de ingresar a la página oficial de Docker ubicada en:
- https://www.docker.com/
En enlace se encuentra en el sitio en la parte de la documentación oficial, en la sección de Docker Compose, en este momento el enlace es:
- https://docs.docker.com/compose/install/
Los pasos consisten en descargar el binario y ubicarlo en una ruta accesible en la terminal, los pasos sugeridos para instalar en Linux son:
Para descargar el binario:   
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
Ahora se le agregan los permisos necesarios para ejecutarlo:   
```
sudo chmod +x /usr/local/bin/docker-compose
```
Si es necesario ubicarlo en otra ruta podemos ejecutar:   
```
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```
Ahora para probar que podemos accederlo ejecutamos:   
```
docker-compose --version
```
Para desinstalarlo ejecutar:   
```
sudo rm /usr/local/bin/docker-compose
```
## Paso 2: Crear el archivo docker-compose.yml para agrupar microservicios
Puedes crear un archivo llamado docker-compose.yml en tu ruta actual con el siguiente contenido:
```
version: '3'
services:
  web:
    image: "nginx"
    ports:
      - "8000:80"
  redis:
    image: "redis"
```
Este archivo crea 2 containers, uno con el servidor web nginx y otro con una base de datos nosql clave valor redis, nginx se expone en el puerto local 8000 redireccionandolo al puerto 80 del container.   
## Paso 3: Administrar los microservicios con Docker Compose
Dentro de la carpeta que contiene le archivo docker-compose.yml ejecutamos:
```
docker-compose up -d
```
Este comando creara estos 2 containers en modo detach es decir en segundo plano, para poder ejecutar otros comandos para verificar si fueron creados exitosamente, para esto ejecuta:
```
docker-compose ps
```
Ahora bien si deseas detener estos containers, debes de ejecutar el siguiente comando:
```
docker-compose stop
```
Si deseas detener y borrar todo ejecuta:
```
docker-compose down
```
Puedes agregar el --volumes para borrar volumenes existentes de datos


## Referencias
- https://docs.docker.com/compose/install/