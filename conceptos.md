##  Conceptos 
----------------------------------------------------------------------------------------------------------------------------------------
__Contenedores__
- Contenedor          : Es un tipo de virtualización que nos permite aislar una aplicación a través de un control group
- Grupo de control    : Es una colección de procesos agrupados que se les puede establecer un limite de uso de recursos (cpu, memoria)
- container runtime   : Para poder ejecutar contenedores existen diferentes tipos de sistemas de ejecución, el más famoso es Docker y su alternativa containerd
- Registro de imagenes: Para poder distribuir las imagenes existen diferentes tipos de registros donde se guardan las imagenes (resultado de construir un contenedor) , el más famoso es docker hub, sin embargo lo normal es tener un registro privado. 
----------------------------------------------------------------------------------------------------------------------------------------
- Kubernetes : Es un sistema de código abierto para la orquestación de contenedores para automatizar el lanzamiento, manejo y escalabilidad de los mismos.
- Nodo       : Un nodo puede ser una máquina virtual (vm), una maquina fisica(bare metal), que forma parte de los recursos de un cluster
- Cluster    : Conjunto de nodos
- Pod        : Unidad minima (abstracción) en donde se puede deployar/instalar un conjunto de contenedores
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
   multipass exec k3s-master -- bash -c "sudo cat /etc/rancher/k3s/k3s.yaml"
```

Contenido del archivo de configuracion
__Nota de seguridad: Nunca suban archivos que comprometan la seguridad como certificados, aquí solo es por cuestión de demonstración__

```bash
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJkekNDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdGMyVnkKZG1WeUxXTmhRREUyT1RnMU1qSTRNemd3SGhjTk1qTXhNREk0TVRrMU16VTRXaGNOTXpNeE1ESTFNVGsxTXpVNApXakFqTVNFd0h3WURWUVFEREJock0zTXRjMlZ5ZG1WeUxXTmhRREUyT1RnMU1qSTRNemd3V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFSelRhQVpZK3BGRkl0WTFaSUNrTlp5L3RBWFowWXRCNTZoZlRxWEdtbnYKdTRZSnNCRUdqUWNNMnlQWVVNaEFhaENjTzZrN1YvM3ExeVlkSW9pZFdQaUFvMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVU1mR3VxYm40Ly9wRlo3cG5qQ3lBClpvWFlkMEl3Q2dZSUtvWkl6ajBFQXdJRFNBQXdSUUlnZlUrbmZaUHFvekdyYmVoTXVqc3dHbkdwMlZTSHRQek0KSDU2WXVPKzdqUm9DSVFDNVp2RmkrVE02SzNXTFlLcHJzQUh4blY4b2pVa0N4SnN4cDlMeUR1TjdkQT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://127.0.0.1:6443
  name: default
contexts:
- context:
    cluster: default
    user: default
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: default
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJrVENDQVRlZ0F3SUJBZ0lJYkxOSWVUQmNsSjR3Q2dZSUtvWkl6ajBFQXdJd0l6RWhNQjhHQTFVRUF3d1kKYXpOekxXTnNhV1Z1ZEMxallVQXhOams0TlRJeU9ETTRNQjRYRFRJek1UQXlPREU1TlRNMU9Gb1hEVEkwTVRBeQpOekU1TlRNMU9Gb3dNREVYTUJVR0ExVUVDaE1PYzNsemRHVnRPbTFoYzNSbGNuTXhGVEFUQmdOVkJBTVRESE41CmMzUmxiVHBoWkcxcGJqQlpNQk1HQnlxR1NNNDlBZ0VHQ0NxR1NNNDlBd0VIQTBJQUJNY0hEbjQxNUkvbkJXR2cKQWxhb1piWUFwdXpGYlpIYlJZL0IwU3ZSVnVNU2lFbEs2YnRvN0F2b200RHBMcTRZZ3o5WWFuMTIzbWxOaWNHQQo5VnZCd3MralNEQkdNQTRHQTFVZER3RUIvd1FFQXdJRm9EQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBakFmCkJnTlZIU01FR0RBV2dCUTBFM05kZzZpcmdLNEIzWVUxOEpKUFlWK01OekFLQmdncWhrak9QUVFEQWdOSUFEQkYKQWlCcHlFQWhud1FrdVh3UHdCd1J4dUxQTFhHRVUyUG9hRjA0YnFhVE9SMVBXd0loQU9WS29jajJ3dTU1T0ZjWAp0U1hpemlqaXdnMlA0Q1AzYVZGclAzVGZIeHlqCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0KLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJlRENDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdFkyeHAKWlc1MExXTmhRREUyT1RnMU1qSTRNemd3SGhjTk1qTXhNREk0TVRrMU16VTRXaGNOTXpNeE1ESTFNVGsxTXpVNApXakFqTVNFd0h3WURWUVFEREJock0zTXRZMnhwWlc1MExXTmhRREUyT1RnMU1qSTRNemd3V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFRb2dnanlud3B3SC9iUUVlUkNjeENuRmJVZ1JVcVo3L2pna1pTZm1mTUMKL21LdEJOREFhdjRoQXYycTRnQkcyT0pRZDF2RGdOdFJicHgzZ0RYdUMvT1FvMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVU5CTnpYWU9vcTRDdUFkMkZOZkNTClQyRmZqRGN3Q2dZSUtvWkl6ajBFQXdJRFNRQXdSZ0loQUpFbm1talIxVklldEpmb2UxM3hMdE1xanNLb0hVUDEKelZ4R05aVnptdmQxQWlFQWhkT05jUDIrYkdKVmdFRlRvYi82clZPaUNMejdCQmZpTzVBd0JaSm91cGs9Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    client-key-data: LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSUd1QVlhSERYa2Zsd1pFZXR5aFpLOGQyVUtOYUFaOXJzOW9xMDJwU2hsSmRvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFeHdjT2ZqWGtqK2NGWWFBQ1ZxaGx0Z0NtN01WdGtkdEZqOEhSSzlGVzR4S0lTVXJwdTJqcwpDK2liZ09rdXJoaURQMWhxZlhiZWFVMkp3WUQxVzhIQ3p3PT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo=
```

si ejecutamos desde nuestra maquina host, solo necesitamos modificar la direccion ip, para poder acceder del host -> master guest
```
   export KUBECONFIG=<path from your host>
   kubectl get nodes
   kubectl get pods --all-namespaces
```

en mi caso es 
```
$ export KUBECONFIG=$HOME/repos/kcuc/scripts/config.yaml
$ kubectl get nodes
NAME          STATUS   ROLES                  AGE   VERSION
k3s-worker2   Ready    <none>                 27m   v1.27.6+k3s1
k3s-master    Ready    control-plane,master   27m   v1.27.6+k3s1
k3s-worker1   Ready    <none>                 27m   v1.27.6+k3s1

$kubectl get pods --all-namespaces
NAMESPACE     NAME                                     READY   STATUS      RESTARTS   AGE
kube-system   local-path-provisioner-957fdf8bc-8z6th   1/1     Running     0          28m
kube-system   coredns-77ccd57875-7nznn                 1/1     Running     0          28m
kube-system   metrics-server-648b5df564-btwkt          1/1     Running     0          28m
kube-system   helm-install-traefik-crd-2f8w9           0/1     Completed   0          28m
kube-system   helm-install-traefik-kwlbv               0/1     Completed   1          28m
kube-system   svclb-traefik-facebb17-nwvqx             2/2     Running     0          27m
kube-system   svclb-traefik-facebb17-2wsh6             2/2     Running     0          27m
kube-system   svclb-traefik-facebb17-mstxq             2/2     Running     0          27m
kube-system   traefik-64f55bb67d-vbvw8                 1/1     Running     0          27m
```

los servicios como tal no tienen acceso desde el exterior, para eso necesitamos habilitar el ingreso

## configurando el ingreso
```
 kubectl -n witcom apply -f scripts/ingress.yaml
 ingress.networking.k8s.io/nginx created

 kubectl describe ingress nginx
 kubectl -n witcom describe ingress nginx
Name:             nginx
Labels:           <none>
Namespace:        witcom
Address:          172.31.113.111,172.31.114.105,172.31.119.253
Ingress Class:    traefik
Default backend:  <default>
Rules:
  Host        Path  Backends
  ----        ----  --------
  *
              /   nginx:80 (10.42.0.8:80,10.42.1.4:80,10.42.2.3:80)
Annotations:  ingress.kubernetes.io/ssl-redirect: false
Events:       <none>
```

clue:  kubectl -n witcom logs <pod name>

__experimento 1 accede al access log de nginx /var/log/nginx__
__experimento 2 apaga uno de los contenedores__
__experimento 3 apaga una de las maquinas virtuales__

