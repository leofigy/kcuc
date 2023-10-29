### for the custom app first we need to publish the image to some registry


docker tag witcom:latest new-repo:tagname
docker push new-repo:tagname

Simple unitest to know it works
```
docker build -t witcom
[+] Building 31.6s (11/11) FINISHED                                                                      docker:default
 => [internal] load build definition from Dockerfile                                                               0.0s
 => => transferring dockerfile: 207B                                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/golang:1.21-alpine                                              2.7s
 => [stage-0 1/5] FROM docker.io/library/golang:1.21-alpine@sha256:926f7f7e1ab8509b4e91d5ec6d5916ebb45155b0c8920  11.0s
 => => resolve docker.io/library/golang:1.21-alpine@sha256:926f7f7e1ab8509b4e91d5ec6d5916ebb45155b0c8920291ba9f36  0.0s
 => => sha256:40a4303e95078c253686dcc16d7717644af63809efcbd753c0a999c9aad3fe72 67.01MB / 67.01MB                   6.8s
 => => sha256:926f7f7e1ab8509b4e91d5ec6d5916ebb45155b0c8920291ba9f361d65385806 1.65kB / 1.65kB                     0.0s
 => => sha256:27c76dcf886c5024320f4fa8ceb57d907494a3bb3d477d0aa7ac8385acd871ea 1.16kB / 1.16kB                     0.0s
 => => sha256:95ab9ef00f5dafa4fd07ff785b25a043560329bfca6db5c6b3ec3a0a3e6dc64f 6.32kB / 6.32kB                     0.0s
 => => sha256:96526aa774ef0126ad0fe9e9a95764c5fc37f409ab9e97021e7b4775d82bf6fa 3.40MB / 3.40MB                     0.7s
 => => sha256:cc37b24bb09971feb8bf4882e861bce9db0c985a16a900adb0dc9de3f854243b 284.69kB / 284.69kB                 0.6s
 => => sha256:359925be0f358b952dc8be63647139c5aab0fff94f7a070d88cb51dd258f80e5 155B / 155B                         0.9s
 => => extracting sha256:96526aa774ef0126ad0fe9e9a95764c5fc37f409ab9e97021e7b4775d82bf6fa                          0.1s
 => => extracting sha256:cc37b24bb09971feb8bf4882e861bce9db0c985a16a900adb0dc9de3f854243b                          0.0s
 => => extracting sha256:40a4303e95078c253686dcc16d7717644af63809efcbd753c0a999c9aad3fe72                          3.9s
 => => extracting sha256:359925be0f358b952dc8be63647139c5aab0fff94f7a070d88cb51dd258f80e5                          0.0s
 => [internal] load build context                                                                                  0.5s
 => => transferring context: 11.28MB                                                                               0.5s
 => [stage-0 2/5] WORKDIR /src                                                                                     0.1s
 => [stage-0 3/5] COPY . .                                                                                         0.0s
 => [stage-0 4/5] RUN go mod download                                                                              8.1s
 => [stage-0 5/5] RUN go build -o /bin/app                                                                         9.3s
 => [stage-1 1/1] COPY --from=0 /bin/app /bin/app                                                                  0.1s
 => exporting to image                                                                                             0.1s
 => => exporting layers                                                                                            0.1s
 => => writing image sha256:bfcc05a21bfe6ff13f4f91614007e4e34200ed6b5b146eb6834046cf99def4ff                       0.0s
 => => naming to docker.io/library/test                                                                            0.0s

$ docker images
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
test         latest    bfcc05a21bfe   5 minutes ago   10.4MB
witcom       latest    bfcc05a21bfe   5 minutes ago   10.4MB
```

run your container with docker so we know is okay
```
$ docker run --publish 90:90 witcom
2023/10/29 02:07:50 ------------------------------- custom ----------------------------
[GIN-debug] [WARNING] Creating an Engine instance with the Logger and Recovery middleware already attached.

[GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
 - using env:   export GIN_MODE=release
 - using code:  gin.SetMode(gin.ReleaseMode)

[GIN-debug] GET    /ping                     --> main.main.func1 (3 handlers)
[GIN-debug] GET    /                         --> main.main.func2 (3 handlers)
[GIN-debug] GET    /health                   --> main.main.func3 (3 handlers)
[GIN-debug] [WARNING] You trusted all proxies, this is NOT safe. We recommend you to set a value.
Please check https://pkg.go.dev/github.com/gin-gonic/gin#readme-don-t-trust-all-proxies for details.
[GIN-debug] Listening and serving HTTP on :90
[GIN] 2023/10/29 - 02:08:03 | 200 |      57.046µs |      172.17.0.1 | GET      "/"
[GIN] 2023/10/29 - 02:08:14 | 200 |      29.656µs |      172.17.0.1 | GET      "/health"
```

let's send the image to remote desktop
```
docker tag witcom:latest leofigydroid/kcuc:latest
docker push leofigydroid/kcuc
Using default tag: latest
The push refers to repository [docker.io/leofigydroid/kcuc]
506845e1312e: Pushed
latest: digest: sha256:7b07d7ee7d3c7db84f4c0f238503444c331c0403865d4d099326f6c71776eff0 size: 527
```

### [regresar](kcuc.md)
