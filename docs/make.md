# Building on UNIX-like systems
The results of all builds can be found in the `./dist/` directory.

## Build binary
```
sudo apt install -y make golang-go
VERSION=??? make
```

## Create DEB package
```
sudo apt install -y make golang-go dpkg hashdeep gzip
VERSION=??? make
VERSION=??? MAINTAINER="anon <anon@localhost> DEBARCH=amd64 make rpm"
```

## Create RPM package
```
sudo apt install -y make golang-go rpm
VERSION=??? make
VERSION=??? MAINTAINER="anon <anon@localhost> RPMARCH=amd64 make rpm"
```
