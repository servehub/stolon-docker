FROM postgres:10.5

RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data/stolon && \
    chmod 700 /data/stolon && \
    chown postgres:postgres -R /data/stolon

VOLUME ["/data/stolon"]

ENV STOLON_VERISON="0.12.0"

RUN curl -Lfs https://github.com/sorintlab/stolon/releases/download/v${STOLON_VERISON}/stolon-v${STOLON_VERISON}-linux-amd64.tar.gz \
      -o /tmp/stolon.tar.gz \
    && tar -xzf /tmp/stolon.tar.gz -C /tmp \
    && cp /tmp/stolon-v${STOLON_VERISON}-linux-amd64/bin/* /usr/local/bin/ \
    && rm -rf /tmp/stolon*

USER postgres
