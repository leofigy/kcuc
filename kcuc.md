## Custom app

Hasta el momento hemos usado comandos directos, también se pueden usar templates en yaml
obviamente esto es un poco rústico, porque existe una herramienta llamada Helm, donde podemos hacer templates 
(helm charts), que facilitan la vida, pero por el momento lo haremos manual :) para seguir explicando los conceptos

Hemos creado una app custom para [demo](localbuild.md)

```
kubectl apply -f custom/kcuc.yaml
kubectl create service clusterip kcuc --tcp=90:90
kubectl apply -f custom/ingress.yaml
```

__experimento que sucede si el proceso principal muere__

Ahora resumiendo tenemos 2 servicios corriendo en el cluster, escuchando por diferentes puertos,
para el usuario es transparente no se da cuenta que servicio lo esta atendiendo

```
$ kubectl -n witcom get all
NAME                        READY   STATUS    RESTARTS   AGE
pod/nginx-55f598f8d-t2bbk   1/1     Running   0          6m45s
pod/nginx-55f598f8d-psnbn   1/1     Running   0          6m45s
pod/nginx-55f598f8d-89tjp   1/1     Running   0          6m45s

NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/nginx   ClusterIP   10.43.249.254   <none>        80/TCP    6m25s

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   3/3     3            3           6m45s

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-55f598f8d   3         3         3       6m45s

leofi@lab-dev MINGW64 ~
$ kubectl get all
NAME                                   READY   STATUS    RESTARTS   AGE
pod/kcuc-deployment-749668576b-9qtv9   1/1     Running   0          11m
pod/kcuc-deployment-749668576b-wrwv4   1/1     Running   0          11m
pod/kcuc-deployment-749668576b-jl45s   1/1     Running   0          11m

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.43.0.1       <none>        443/TCP   57m
service/kcuc         ClusterIP   10.43.117.109   <none>        90/TCP    11m

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kcuc-deployment   3/3     3            3           11m

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/kcuc-deployment-749668576b   3         3         3       11m

```
y el ingreso esta seteado para ambos 
```
leofi@lab-dev MINGW64 ~/repos/kcuc (main)
$ kubectl -n witcom describe ingress nginx
Name:             nginx
Labels:           <none>
Namespace:        witcom
Address:          172.26.104.74,172.26.108.75,172.26.111.224
Ingress Class:    traefik
Default backend:  <default>
Rules:
  Host        Path  Backends
  ----        ----  --------
  *
              /   nginx:80 (10.42.0.10:80,10.42.1.5:80,10.42.2.6:80)
Annotations:  ingress.kubernetes.io/ssl-redirect: false
Events:       <none>

leofi@lab-dev MINGW64 ~/repos/kcuc (main)
$ kubectl describe ingress kcuc
Name:             kcuc
Labels:           <none>
Namespace:        default
Address:          172.26.104.74,172.26.108.75,172.26.111.224
Ingress Class:    traefik
Default backend:  <default>
Rules:
  Host        Path  Backends
  ----        ----  --------
  *
              /witcom   kcuc:90 (10.42.0.9:90,10.42.1.4:90,10.42.2.5:90)
Annotations:  ingress.kubernetes.io/ssl-redirect: false
Events:       <none>
```

entonces si hacemos una consulta 

```
leofi@lab-dev MINGW64 ~/repos/kcuc (main)
$ curl 172.26.104.74:80/witcom
{"message":"hello world, I'm kcuc-deployment-749668576b-9qtv9"}
leofi@lab-dev MINGW64 ~/repos/kcuc (main)
$ curl 172.26.104.74:80/
<!DOCTYPE html>
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
```

regresará el resultado en enruntandolo de forma correcta, btw happy clustering , we're done pals

### [regresar](README.md)
