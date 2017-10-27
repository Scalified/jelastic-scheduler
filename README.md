# Jelastic CLI/Cron Docker #

[![Docker Pulls](https://img.shields.io/docker/pulls/scalified/jelastic-scheduler.svg)](https://hub.docker.com/r/scalified/jelastic-scheduler)
[![](https://images.microbadger.com/badges/image/scalified/jelastic-scheduler.svg)](https://microbadger.com/images/scalified/jelastic-scheduler)
[![](https://images.microbadger.com/badges/version/scalified/jelastic-scheduler.svg)](https://microbadger.com/images/scalified/jelastic-scheduler)

## Description

This repository is used for building a Docker image containing [**Cron**](https://en.wikipedia.org/wiki/Cron) and
[**JelasticCLI**](https://docs.jelastic.com/cli) running on [**Alpine Linux**](https://alpinelinux.org/).

## Docker Store
To pull the image from [Docker Store](https://store.docker.com/community/images/scalified/jelastic-scheduler):

**`docker pull scalified/jelastic-scheduler`**

This image extends [scalified/alpine-cron](https://store.docker.com/community/images/scalified/alpine-cron) docker image.

## Volumes

* **`/root/.scripts`**
* **`/root/jelastic`**
* **`/var/spool/cron/crontabs`**
* **`/root/.config/jelastic`**

### How-To

#### Building Docker Image

`docker build . -t <tag>`

#### Running Docker Image

`docker run -it scalified/jelastic-scheduler /bin/sh`

## Scalified Links

* [Scalified](http://www.scalified.com)
* [Scalified Official Facebook Page](https://www.facebook.com/scalified)
* Scalified Support - info@scalified.com