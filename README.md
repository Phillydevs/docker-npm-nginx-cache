# Docker npm cache

Npm cache using nginx.

Blatantly copied from http://eng.yammer.com/a-private-npm-cache/


## Dependencies

- http://docker.io


## Usage

```bash

# Build
$ make
# or $ docker build --rm -t npm-nginx-cache .

# run (listening on port 8080)
$ docker run -p 8080:80 -d npm-nginx-cache
```
