# Copied from https://github.com/prometheus/client_golang/blob/master/examples/simple/Dockerfile

FROM public.ecr.aws/docker/library/golang:1.20-alpine AS builder
WORKDIR /go/src/github.com/infrastructure-as-code/docker-hello-world
ENV GIN_MODE debug
COPY .* * ./
RUN \
  uname -a ** \
  apk update && \
	apk upgrade && \
	apk add \
    alpine-sdk \
  && \
	make all

FROM ghcr.io/vincetse/scratch
LABEL maintainer "Vince Tse <vincetse@users.noreply.github.com>"
COPY --from=builder /go/src/github.com/infrastructure-as-code/docker-hello-world/hello_world .
ENV GIN_MODE release
EXPOSE 8080
ENTRYPOINT ["/hello_world"]
