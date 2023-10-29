## Custom app

Hasta el momento hemos usado comandos directos, también se pueden usar templates en yaml
obviamente esto es un poco rústico, porque existe una herramienta llamada Helm, donde podemos hacer templates 
(helm charts), que facilitan la vida, pero por el momento lo haremos manual :) para seguir explicando los conceptos

Hemos creado una app custom para [demo](localbuild.md)

```
kubectl apply -f custom/kcuc.yaml
```