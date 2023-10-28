## Montando nginx

Ahora que tenemos nuestros nodos, cluster y kubectl configurado, 
podemos montar rápidamente un servidor web

¿Qué necesitamos?
- un namespace
- un deployment
- un servicio
- un ingress 

kubernetes soporta namespaces

```
kubectl create namespace witcom
kubectl -n witcom create deployment nginx --image=nginx --port=80 --replicas=3

kubectl -n witcom get all
NAME                        READY   STATUS              RESTARTS   AGE
pod/nginx-55f598f8d-hk56m   0/1     ContainerCreating   0          15s
pod/nginx-55f598f8d-xxcsk   0/1     ContainerCreating   0          15s
pod/nginx-55f598f8d-7qkjm   0/1     ContainerCreating   0          15s

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   0/3     3            0           15s

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-55f598f8d   3         3
```

aun no configuramos la salida del deployment si queremos ver como funciona o que nodo esta 
```
kubectl -n witcom get pod -o wide
NAME                    READY   STATUS    RESTARTS   AGE   IP          NODE          NOMINATED NODE   READINESS GATES
nginx-55f598f8d-hk56m   1/1     Running   0          16m   10.42.2.3   k3s-worker2   <none>           <none>
nginx-55f598f8d-xxcsk   1/1     Running   0          16m   10.42.1.4   k3s-worker1   <none>           <none>
nginx-55f598f8d-7qkjm   1/1     Running   0          16m   10.42.0.8   k3s-master    <none>           <none>
```

Para acceder a un pod , se puede realizar `kubectl -n witcom exec -ti <pod name> -- sh`
```
$ kubectl -n witcom exec -ti nginx-55f598f8d-hk56m -- sh
Unable to use a TTY - input is not a terminal or the right kind of file
ls
bin
boot
dev
docker-entrypoint.d
docker-entrypoint.sh
etc
home
lib
lib32
lib64
libx32
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var

curl localhost:80
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
1<!DOCTYPE html>   0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
00   615  100   615    0     0   245k      0 --:--:-- --:--:-- --:--:--  300k
```
Podemos ver que nginx esta corriendo dentro del contenedor, 

ahora que sucede si tratamos de hacer curl <node>:80?