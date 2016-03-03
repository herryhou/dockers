#用 go 來 render 地圖
go + mapnik3 （使用 stretch 裡面的 libmapnik-dev 3.0.9+ds-1)

Dockerfile
```
FROM herryhou/gomapnikdev:latest
EXPOSE 8080
WORKDIR /usr
ENV GOPATH /usr
RUN go get -d github.com/herryhou/go-mapnik/mapnik && \
    go get -d github.com/herryhou/go-mapnik/maptiles && \
    cd /usr/src/github.com/herryhou/go-mapnik/mapnik && \
    cp ./configure.bash /tmp && \
    chmod +x /tmp/configure.bash && \
    /tmp/configure.bash
RUN cd /usr/src/github.com/herryhou/go-mapnik && \
    go build -a -installsuffix cgo main.go && \
    mv main /tmp && \
    chmod +x /tmp/main

CMD ["/tmp/main"]
#sudo docker run -ti -e "PGUSER=postgres" -e "PGPASSWORD=yours@secret" -v /vagrant/compose/gomapnik/src:/usr/src -v /vagrant/compose/tessera:/src -p 8088:8080 vagrant_gomapnik bash
```

docker-compose.yml
```
gomapnik:
  build: "./compose/gomapnik"
  hostname: gomapnik
  environment:
    PGUSER: "postgres"
    PGPASSWORD: "yours@secret"
  links:
    - postgis:postgis
  volumes:
    - /vagrant/compose/gomapnik/src:/usr/src
    - /vagrant/compose/tessera:/src
  ports:
    - "8088:8080"
```
