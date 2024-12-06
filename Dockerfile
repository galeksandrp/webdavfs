FROM golang:1.23.4-bookworm
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git \
  fuse \
  && rm -rf /var/lib/apt/lists/*
RUN go get
RUN go build
RUN mv webdavfs /sbin/mount.webdavfs
