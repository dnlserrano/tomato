FROM elixir:1.5.3

MAINTAINER Daniel Serrano "danieljdserrano@protonmail.com"

ENV TERM xterm
ENV HOME /root
ENV LANG=en_GB.UTF-8

COPY . /var/code/tomato

WORKDIR /var/code/tomato

ENTRYPOINT tail -f /dev/null
