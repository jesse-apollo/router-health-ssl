include .env

ROUTER_RELEASE=v1.59.2
ROUTER_DL_PREFIX=https://github.com/apollographql/router/releases/download

build:
	rm -rf dist
	curl -L --clobber ${ROUTER_DL_PREFIX}/${ROUTER_RELEASE}/router-${ROUTER_RELEASE}-x86_64-unknown-linux-gnu.tar.gz -o router.tar.gz
	tar zxf router.tar.gz 
	mv dist/router router.amd64
	rm -rf router.tar.gz dist
	docker build --platform linux/amd64 -f  Dockerfile . -t router-amd64:latest

build-arm64:
	rm -rf dist
	curl -L --clobber ${ROUTER_DL_PREFIX}/${ROUTER_RELEASE}/router-${ROUTER_RELEASE}-aarch64-unknown-linux-gnu.tar.gz -o router.arm64.tar.gz
	tar zxf router.arm64.tar.gz
	mv dist/router router.arm64
	rm -rf router.arm64.tar.gz dist
	docker build --platform linux/arm64   -f  Dockerfile.arm64 . -t router-arm64:latest

test-cert:
	openssl req -sha256 -new -x509 -nodes -out server.pem -keyout server.key

run:
	docker run -t -i --env-file .env -p 8080:8080 -p 4000:4000 router-amd64:latest

run-arm64: 
	docker run -t -i --env-file .env -p 8080:8080 -p 4000:4000 --rm --name router-arm router-arm64:latest

run-arm64-it:
	docker exec -it --env-file .env  router-arm bash

check-cert:
	openssl s_client -connect localhost:8080 -showcerts -prexit

test:
	curl -v -k https://localhost:8080/health