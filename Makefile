# достаем и экпортируем нужные ENV VARS
include .env
export NETWORK REGRUDNS_EMAIL REGRUDNS_USER
export REGRUDNS_DOMAIN REGRUDNS_PASS

all: docker-compose

# имена сервисов и целей могут совпадть, делаем для них phony
#.PHONY: load_db

# извлекаем аргументы цели
TARGET_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
$(eval $(TARGET_ARGS):;@true)


docker-compose:
	UNAME=$$(uname -s); \
	if [ "$$UNAME" = "Darwin" ]; then \
	  make darwin; \
	  semantic="cached"; \
	else \
	  semantic="consistent"; \
	fi; \
	export semantic; \
	envsubst '$${semantic}' < docker-compose.template.yml > common.yml
	docker run --rm -i -v $$(pwd):/opt python:3-alpine sh \
	-c 'pip install --upgrade pip; pip install ruamel.yaml; cd /opt; /opt/build.py'

init: network docker-compose pull

pull: vas-docker-pull translator-pull

renewcert:
	if [ -z "$(docker image ls | grep renewcert)" ]; then \
		docker build --rm -t renewcert certbot/; \
	fi; \
	docker run --rm -v $(pwd)/../certs:/root/certs \
		-e REGRUDNS_EMAIL=$(REGRUDNS_EMAIL) -e REGRUDNS_USER=$(REGRUDNS_USER) \
		-e REGRUDNS_PASS=$(REGRUDNS_PASS) -e REGRUDNS_DOMAIN=$(REGRUDNS_DOMAIN) \
			renewcert /root/renew_cert.sh

vas-docker-pull:
	if [ -d "./.git" ]; then \
		GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git pull origin master; \
	else \
	    echo -e "Целевая директория уже существует. Читайте документацию по Git...\n(и не ебите мне мозги...)"; \
	fi

translator-pull:
	if [ -d "../translator/.git" ]; then \
		cd ../translator; \
		GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git pull origin master; \
		cd ../vas-docker; \
	else \
		GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git clone git@github.com:SubminO/translator.git ../translator; \
	fi

start: run

run:
	docker-compose up -d $(TARGET_ARGS)

stop:
	docker-compose stop $(TARGET_ARGS)

restart:
	docker-compose stop $(TARGET_ARGS)
	docker-compose up -d $(TARGET_ARGS)

rm:
	docker-compose stop
	docker-compose rm -f
	docker ps | awk '{print $$1}' | grep -v CONTAINER | xargs --no-run-if-empty docker kill
	docker ps --filter 'status=exited' | awk '{print $$1}' | grep -v CONTAINER | xargs --no-run-if-empty docker rm

reload:
	make rm && make run

modules:
	make track-docker-pull
	docker-compose run trackfull
#	docker-compose restart

network:
	if ! docker network ls | grep -q $(NETWORK); then \
		docker network create $(NETWORK); \
	fi

darwin:
	echo "С Mac OS возможно потребует чтения доп документации"
