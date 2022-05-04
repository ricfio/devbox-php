# Sandbox PHP (vanilla)

A sandbox to develop [PHP](https://www.php.net/) projects.  

## Getting started

To build the docker environment, install the dependencies (composer install) and login in the app container:  

```bash
make docker-start docker-login
```

Now, you can open your browser at the app homepage (tcp port 8000):

- [Homepage](http://localhost:8000/)

### vscode

The project includes vscode .devcontainer folder to automatize the build and develop or debug inside the docker container.  

### make

The project includes a Makefile to quickly execute some main tasks.  

`make`

```console
Usage:
  make <target>

  backup                       Backup codebase (*_YYYYMMDD_HHMM.tar.gz)
  check                        Check codebase
  clear                        Clear cache
  docker-login                 Environment login
  docker-start                 Environment start (docker-compose up)
  docker-stop                  Environment stop (docker-compose down)
  install                      Install packages (composer install)
  server-start                 Start server
  server-stop                  Stop server
  test                         Test codebase (phpunit)
  update                       Update packages (composer update)
```

### git-hook (pre-commit)

You can also use the bash script `./git-hook.sh` to manage the `.git/hooks/pre-commit`.

`./git-hook.sh`

```console
Usage:  git-hooks.sh [COMMAND]

Commands:
  install            Install .git/hooks/precommit
  uninstall          Uninstall .git/hooks/pre-commit
  run                Run ./scripts/git-hooks/pre-commit.sh
```

`./git-hooks.sh run`

```console
  Coding Standard
    ✔ PHP CS Fixer
    ✔ PHP Mess Detector

  Static Analysis
    ✔ Psalm
    ✔ PHPArkitect

  Test Execution
    ✔ PHPUnit
```

You can change `./scripts/git-hooks/pre-commit.sh` to customize it with your preferences.

`vi ./scripts/git-hooks/pre-commit.sh`

## Appendix

### Packages

This sandbox includes the following packages:

| Name           | Package                   |
|----------------|---------------------------|
| PHPUnit        | phpunit/phpunit           |
| PHP CS Fixer   | friendsofphp/php-cs-fixer |
| PHPStan        | phpstan/phpstan           |
| PHPMD          | phpmd/phpmd               |
| Psalm          | vimeo/psalm               |
| PHPArkitect    | phparkitect/phparkitect   |
