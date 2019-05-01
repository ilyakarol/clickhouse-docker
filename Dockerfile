FROM ubuntu:18.04
RUN apt-get update -qq && apt-get install -y libgcc-7-dev locales tzdata wget

COPY clickhouse_debian_packages.txt /tmp/clickhouse_debian_packages.txt

RUN cat /tmp/clickhouse_debian_packages.txt | while read package; \
    do \
    TEMP_DEB="$(mktemp)" && \
    wget -O "$TEMP_DEB" $package  && \
    dpkg -i "$TEMP_DEB" && \
    rm -f "$TEMP_DEB"; \
    done

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir /docker-entrypoint-initdb.d

COPY docker_related_config.xml /etc/clickhouse-server/config.d/
COPY entrypoint.sh /entrypoint.sh
ADD https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 /bin/gosu

RUN chmod +x \
    /entrypoint.sh \
    /bin/gosu

EXPOSE 9000 8123 9009
VOLUME /var/lib/clickhouse

ENV CLICKHOUSE_CONFIG /etc/clickhouse-server/config.xml

ENTRYPOINT ["/entrypoint.sh"]
