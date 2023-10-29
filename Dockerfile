FROM golang:1.21-alpine

WORKDIR /src
COPY . . 
RUN go mod download
RUN go build -o /bin/app

FROM scratch
COPY --from=0 /bin/app /bin/app

CMD ["/bin/app"]
