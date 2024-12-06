FROM golang:1.23.4-bookworm
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git \
  fuse \
  && rm -rf /var/lib/apt/lists/*
COPY . /root/webdavfs
WORKDIR /root/webdavfs
RUN go get
RUN go build
RUN mv webdavfs /sbin/mount.webdavfs
CMD [ "sh", "-c", "mount -t webdavfs -ousername=$DAV_USERNAME,password=$DAV_PASSWORD $DAV_URL $DAV_DIRPATH && APPPID=$(mount.webdavfs) && exec tail --pid=$APPPID -f /dev/null" ]
