FROM elixir:1.9.1-alpine as builder

LABEL company="Pharos Production Inc."
LABEL version="0.1.0"

ENV LANG C.UTF-8 \
  REFRESHED_AT 2019-09-14-1 \
  TERM xterm \
  DEBIAN_FRONTEND noninteractive
ENV ELIXIR_VERSION v1.9.1
ENV VERSION 0.1.0

RUN apk add --update \
  git \
  build-base \
  wget \
  bash

WORKDIR /opt/server-builder/
COPY . /opt/server-builder/

RUN mix local.hex --force && mix local.rebar --force
RUN MIX_ENV=prod mix do deps.get --only prod, deps.compile --force
RUN mix deps.clean mime --build 
RUN MIX_ENV=prod mix distillery.release --env=prod

RUN mkdir /opt/server \
  && tar xvzf ./_build/prod/rel/server/releases/${VERSION}/server.tar.gz -C /opt/server
  
RUN rm -rf /opt/server-builder

#############################################################

FROM alpine:3.9

LABEL company="Pharos Production Inc."
LABEL version="0.1.0"

ENV LANG C.UTF-8 \
  REFRESHED_AT 2019-09-14-1 \
  TERM xterm \
  DEBIAN_FRONTEND noninteractive

ENV REPLACE_OS_VARS=true \
  HOSTNAME=${HOSTNAME} \
  ERL_CRASH_DUMP_SECONDS=10 \
  HEART_BEAT_TIMEOUT=30 \
  HEART_KILL_SIGNAL=SIGABRT \
  HEART_NO_KILL=0 \
  HEART_COMMAND=reboot

RUN apk add --update \
  bash \
  openssl

COPY --from=builder /opt/server /usr/local/bin/server
WORKDIR /usr/local/bin/server/bin

EXPOSE 8081 50051

CMD /bin/bash