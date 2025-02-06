# Apollo Router w/ SSL Health Check

A Dockerfile to build Apollo Router with SSL Health Check (via stunnel).

Internal router bind port: 4000

Internal health check bind port: 8080

## Build

 1. Copy `dot_env` to `.env` and edit appropriate values.
 2. Edit `router-config.yaml` as needed.
 3. Save your SSL certificates to `server.pem` and `server.key` respectively (make test certs via `make test-cert`)
 2. Run `make`

# Run

 1. Copy `dot_env` to `.env` and edit appropriate values.
 2. Run `make run`

Router will be listening on http://localhost:4000, health check will be listening on https://localhost:8080.

# Test

 1. Ensure the container is running.
 2. Check certs: `make check-cert`
 3. Check health: `make test`

