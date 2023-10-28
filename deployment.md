## Deployment 

Conceptos 
----------------------------------------------------------------------------------------------------------------------------------------
--Contenedores--
- Contenedor          : Es un tipo de virtualizacion que nos permite aislar una aplicacion a traves de un control group
- Grupo de control    : Es una collecion de procesos agrupados que se les puede establecer un limite de uso de recursos (cpu, memoria)
- container runtime   : Para poder ejecutar contenedores existen diferentes tipos de sistemas de ejecucion, el mas famoso es Docker y su alternativa containerd
- Registro de imagenes: Para poder distribuir las imagenes existen diferentes tipos de registros donde se guardan las imagenes (resultado de construir un contenedor) , el mas famoso es docker hub, sin embargo lo normal es tener un registro privado. 
----------------------------------------------------------------------------------------------------------------------------------------
- Kubernetes : Es un sistema de codigo abierto para la orquestacion de contenedores para automatizar el lanzamiento, manejo y escalabilidad de los mismos.
- Nodo       : Un nodo puede ser una maquina virtual, una maquina fisica, que forma parte de los recursos de un cluster
- Cluster    : Conjunto de nodos
- Pod        : Unidad minima (abstraccion) en donde se puede deployar/instalar un conjunto de contenedores
- Service    : Un conjunto de pods asociados que representan a una aplicacion
- Ingress    : Expone un a los servicios a fuera del cluster para que sean usados

### Instrucciones
 
Simulamos nuestro cluster de kubernetes usando 3 maquinas virtuales, eso quiere decir que tenemos 3 nodos. 
para poder trabajar con kubectl necesitamos utilizar la configuracion del cluster de kubernetes. 

Por defecto en el master node , esta ubicada la config por defecto en el siguiente path 

```bash
# just for playing a little bit 
   multipass list 
   multi shell k3s-master
   cat /etc/rancher/k3s/k3s.yaml
# or 
   multipass transfer k3s-master:/etc/rancher/k3s/k3s.yaml
```

contenido del archivo de configuracion
```bash


```

si ejecutamos desde nuestra maquina host, solo necesitamos modificar la direccion ip, para poder acceder del host -> master guest
```
   export KUBECONFIG=<path from your host>
   kubectl get nodes
   kubectl get pods --all-namespaces
```
