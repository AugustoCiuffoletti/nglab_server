.PHONY: build run push

REPO  ?= nglab-server
TAG   ?= latest
# DA FARE
# ARCH ?= amd64

push:
	sudo docker build --tag mastrogeppetto/$(REPO):$(TAG) .
	sudo docker push mastrogeppetto/$(REPO):$(TAG)
	

# Rebuild the container image
build:
	docker build -t $(REPO):$(TAG) .

test:
	docker run --privileged --rm -d --name nglab-server $(REPO):$(TAG)
	docker exec -it nglab-server bash

# DA FARE
#  gen-ssl:
#	mkdir -p ssl
#	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#		-keyout ssl/nginx.key -out ssl/nginx.crt

clean: 
	docker rmi $(REPO):$(TAG)
	docker image prune -f
