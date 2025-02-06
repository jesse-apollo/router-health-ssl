FROM debian:bookworm-slim

RUN apt-get update -y && apt-get install -y stunnel4 supervisor

COPY router.amd64 /usr/bin/router
COPY router-config.yaml /etc/router-config.yaml
COPY stunnel.conf /etc/stunnel/stunnel.conf

COPY server.pem /etc/stunnel/cert.pem
COPY server.key /etc/stunnel/key.pem

COPY supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
