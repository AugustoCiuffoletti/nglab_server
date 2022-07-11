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

# Test run the container
# the local dir will be mounted under /src read-only
run:
	docker run --privileged --rm \
		-e USER=user -e PASSWORD=user \
		--name nglab-server \
		$(REPO):$(TAG)

# Connect inside the running container for debugging
shell:
	docker exec -it nglab-server bash
# DA FARE
#  gen-ssl:
#	mkdir -p ssl
#	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#		-keyout ssl/nginx.key -out ssl/nginx.crt

clean: 
	docker rmi $(REPO):$(TAG)
	docker image prune -f
