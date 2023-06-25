# asazanoff_microservices
asazanoff microservices repository

## ДЗ 14
Был сделан докерфайл, который запускает базу данных и приложение в себе. Познакомился с созданием образов и контейнеров из этих образов. Узнал, как работать с докерхабом. Узнал об инструментах, которые позволят дебажить контейнеры и приложения в них.

В процессе также познакомился с docker-machine, который больше не развивается.

## ДЗ 15

В этом ДЗ использовали архитектуру приложения, когда его составные части использовались в разных контейнерах. Также были оптимизированы размеры образов.

Для этого приложения потребуются старые версии базовых образов.
Для Монго используйте `mongo:5.0`
Для post используйте `python:3.5.10-alpine`

Для задания со звездочкой:

```console
docker run -d --network=reddit --network-alias=post_db2 --network-alias=comment_db2 mongo:5.0
```

```console
docker run -d --network=reddit --network-alias=post2 -e POST_DATABASE_HOST=post_db2 asazanoff/post:1.0
```

```console
docker run -d --network=reddit --network-alias=comment2 -e COMMENT_DATABASE_HOST=comment_db2 asazanoff/comment:1.0
```

```console
docker run -d --network=reddit -p 9292:9292 -e POST_SERVICE_HOST=post2 -e COMMENT_SERVICE_HOST=comment2 asazanoff/ui:1.0
```

Для уменьшения образов в comment и ui использовал в докерфайлах

```
FROM alpine:3.13.10

RUN apk update && apk add ruby-full ruby-dev build-base
RUN gem install bundler:1.17.2
```
