FROM golang:1.12.4-alpine3.9
LABEL MAINTAINER="Jan Guzman <janfrancisco19@gmail.com>"

WORKDIR /go/src/github.com/videoeditor

CMD ["tail", "-f", "/dev/null"]