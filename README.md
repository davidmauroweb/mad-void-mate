## Verificar si el usuario pertenece al grupo wheel
Ingresando como usuario ROOT
en /etc/group agregar el usuario creado en la siguiente linea sin las comillas

wheel : x : 4 : "USUARIO"

y en /etc/sudoers

quitar los numerales en:

%wheel ALL=(ALL:ALL) ALL #para pedir clave

o

%wheel ALL=(ALL:ALL) NOPASSWD: ALL #ejecuta sin pedir clave



## mad-void-mate ##

Luego de instalar void sin escritorio, debemos instalar git

$ sudo xbps-install -S git

Clonar el repositorio

$ git clone https://github.com/davidmauroweb/mad-void-mate.git

Cambiarse al subdirectorio mad-void-mate

$ cd mad-void-mate

Ejecutar la guía

$ ./MadVM.sh

Seguir los pasos, la clave para realizar las instalaciones puede ser solicitada varias veces seguín el timeout.
