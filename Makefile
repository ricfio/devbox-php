.PHONY: help backup clear install test update 
.PHONY: check php-cs-fixer phpstan phpmd psalm phparkitect
.PHONY: docker-login docker-start docker-stop
.PHONY: server-start server-stop
.DEFAULT_GOAL := help

help:
	@awk 'BEGIN {FS = ":.*#"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\n"} /^[a-zA-Z0-9_-]+:.*?#/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST); printf "\n"

backup: ## Backup codebase (*_YYYYMMDD_HHMM.tar.gz)
backup: archive=`pwd`_`date +'%Y%m%d_%H%M'`.tar.gz
backup:
	@tar -czf $(archive) --exclude=tools --exclude=var/* --exclude=vendor/* *
	@ls -l `pwd`*.tar.gz

check: ## Check codebase
check: php-cs-fixer phpmd psalm phparkitect

# phpcbf:
# 	./vendor/bin/phpcbf -s

php-cs-fixer:
	./tools/php-cs-fixer/vendor/bin/php-cs-fixer fix --dry-run --verbose --diff --config=.php-cs-fixer.php

phpstan:
	./vendor/bin/phpstan analyse src tests --memory-limit 256M

phpmd:
	./vendor/bin/phpmd src,tests ansi phpmd.xml --exclude src/Kernel.php

psalm:
	./vendor/bin/psalm --show-info=true

phparkitect:
	./vendor/bin/phparkitect check

# deptrac:
# 	./vendor/bin/deptrac --formatter=graphviz

clear: ## Clear codebase
	@cd .                    && rm -fr composer.lock vendor/*
	@cd ./tools/php-cs-fixer && rm -fr composer.lock vendor/*
	@rm -fr var/cache/*

docker-login: ## Environment login
	@docker-compose exec php bash

docker-start: ## Environment start (docker-compose up)
	@docker-compose build --no-cache
	@docker-compose up -d
	@docker-compose exec php bash -c 'make install'

docker-stop: ## Environment stop (docker-compose down)
	@docker-compose down

install: ## Install packages (composer install)
	@cd .                    && rm -fr composer.lock vendor/* && composer install
	@cd ./tools/php-cs-fixer && rm -fr composer.lock vendor/* && composer install

server-start: ## Start server
	php -S localhost:8000 -t public/

server-stop: ## Stop server
	killall php

test: ## Test codebase (phpunit)
	@./vendor/bin/phpunit

update: ## Update packages (composer update)
	@cd .                    && composer update
	@cd ./tools/php-cs-fixer && composer update
