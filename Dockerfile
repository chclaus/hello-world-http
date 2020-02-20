FROM golang:alpine AS target
#RUN apk --no-cache add build-base git bzr mercurial gcc
RUN mkdir /src
ADD main.go /src
RUN cd /src && go build -o app

FROM alpine:latest
COPY --from=target /src/app /app/
RUN adduser --disabled-password -g 2000 -u 2000 web-app
USER web-app
WORKDIR /app
ENTRYPOINT ./app