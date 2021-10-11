FROM postgres:13.4

ENV POSTGIS_MAJOR="3"
ENV POSTGIS_VERSION="3.1.4+dfsg-1.pgdg110+1"

RUN apt-get update \
    && apt-get install -y \
      curl \
      postgresql-${PG_MAJOR}-postgis-${POSTGIS_MAJOR}=${POSTGIS_VERSION} \
      postgresql-${PG_MAJOR}-postgis-${POSTGIS_MAJOR}-scripts=${POSTGIS_VERSION} \
      postgis=${POSTGIS_VERSION} \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data/stolon && \
    chmod 700 /data/stolon && \
    chown postgres:postgres -R /data/stolon

VOLUME ["/data/stolon"]

ENV STOLON_VERSION="0.17.0"

RUN curl -Lfs https://github.com/sorintlab/stolon/releases/download/v${STOLON_VERSION}/stolon-v${STOLON_VERSION}-linux-amd64.tar.gz \
      -o /tmp/stolon.tar.gz \
    && tar -xzf /tmp/stolon.tar.gz -C /tmp \
    && cp /tmp/stolon-v${STOLON_VERSION}-linux-amd64/bin/* /usr/local/bin/ \
    && rm -rf /tmp/stolon*

USER postgres
