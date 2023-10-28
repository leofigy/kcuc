## Deployment 

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
