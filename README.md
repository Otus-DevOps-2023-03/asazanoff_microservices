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

## ДЗ 15

В этом ДЗ познакомился с драйверами сетей для Докера: none, host. Изучил, как работает bridge-сеть в Докере.

После нескольких вызовов команды `docker run --network host -d nginx` остается запущенным только первый контейнер `docker ps`, так как последующие контейнеры не могут себе забрать порт 80.

Для формирования имени используется имя каталога, откуда запускается `docker-compose`. Для изменения имени используйте, например, `name: "koshka"` в YAML-файле для имени проекта. Вторая часть (koshka-**db**-1) формируется как имя контейнера. Циферка -- номер контейнера.

Для дебаггинга есть `docker-compose.override.yml`, но корректное присоединение вольюмов для изменения кода не будет работать, когда используется `docker-machine`. Запускайте Докер Компоуз на хосте с кодом.

## ДЗ 22

Сегодня я познакомился с Prometheus для сбора метрик с микросервисов, самого себя и с хостовой машины при помощи node_exporter.

Образы размещены в [Докер Хабе](https://hub.docker.com/u/asazanoff).

Для создания со звездочкой в Докер Компоуз добавлен экспортер с образом `percona/mongodb_exporter`, а также Блекбокс Экспортер для проверки ответа веб-сервера, перед применением Докер Компоуза подставьте верный внешний IP-адрес машины.

Также был добавлен Makefile для постройки образов и отправки их в Докер Хаб. Определите `USER_NAME` в самом начале файла, а затем в директории с проектом выполните `make`.

## ДЗ 25

В этом занятии я познакомился с инструментами агрегации лог-данных. Понял, что Эластиксерч может собирать и визуализировать данные. Также познакомился с Флюентд, который может парсить логи и форматировать их для удобства разбора в Эластиксерч. 

Для задания со звездочкой добавьте в файл `fluent.conf` разбор наподобие с тем, что есть. Должно получиться примерно так:
```
<filter service.ui>
  @type parser
  key_name message
  <parse>
    @type grok
    <grok>
    pattern service=%{WORD:service} \| event=%{WORD:event} \| request_id=%{GREEDYDATA:request_id} \| message='%{GREEDYDATA:message}'
    </grok>
    <grok>
    pattern service=%{WORD:service} \| event=%{WORD:event} \| path=%{GREEDYDATA:path} \| request_id=%{GREEDYDATA:request_id} \| remote_addr=%{GREEDYDATA:remote_addr} \| method= %{WORD:method} \| response_status=%{WORD:response_status}
    </grok>
  </parse>
</filter>
```

Чтобы сделать второе задание со звездочкой, рекомендую вам проапдейтить все так, чтобы работало на современных версиях. Сейчас все падает, а мучаться очередной раз с тем, чтобы подобрать совместимость, я не хочу. Ответ такой, что в коде намеренно сделана задержка.

## ДЗ 27

В этом домашнем задании я познакомился с утилитой kubeadm и kubectl, и даже получилось запустить контейнеры в подах.

## ДЗ 29

В этом ДЗ мы заставили работать приложение в Кебернетес-кластере, настроив общение между ними при помощи сервисов.

Сервис доступен по адресу http://158.160.31.149:30000/ .

Для разворачивания кластера с нодами примените инфраструктуру Терраформ из директории `kubernetes/reddit-infra/tf-managed/`.

Для доступа к дашбордам примените манифест dashboard.yml: `kubectl apply -f kubernetes/reddit/dashboard.yml`, затем получите токен для доступа к дашборду `kubectl -n kubernetes-dashboard create token admin-user` и запустите `kubectl proxy`. Полученный токен вставьте на странице `http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/` и посмотрите дашборд.
