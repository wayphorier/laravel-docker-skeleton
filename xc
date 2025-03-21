#!/bin/bash

action_exec() {
    shift 1

    $COMPOSE exec --user $(id -u):$(id -g) $@
}

action_artisan() {
    shift 1

    $COMPOSE exec --user $(id -u):$(id -g) laravel php /var/www/html/artisan $@
}

action_composer() {
    shift 1

    docker run --rm -it \
        -v "$(pwd)":/var/www/html \
        --workdir /var/www/html \
        --entrypoint composer \
        --user $(id -u):$(id -g) \
        composer:latest \
        --ignore-platform-reqs \
        $@
}

action_node() {
    shift 1

    $COMPOSE run --rm --user $(id -u):$(id -g) node $@
}

action_up() {
    shift 1

    $COMPOSE up laravel --remove-orphans $@
}

action_up_hmr() {
    shift 1

    $COMPOSE -f docker-compose.hmr.dev.yml up laravel hmr --remove-orphans $@
}

action_down() {
    shift 1

    $COMPOSE down $@
}

action_install() {
    docker run --rm -it \
        -v "$(pwd)"/laravel-temp:/var/www/html \
        --workdir /var/www/html \
        --entrypoint composer \
        composer:latest \
        --ignore-platform-reqs \
        create-project laravel/laravel . \
        && sudo chown -R $(id -u):$(id -g) laravel-temp \
        && cp -r laravel-temp/. "$(pwd)" \
        && sudo rm -rf laravel-temp
}

main() {
    ## Set defaults for our environment
    COMPOSE_FILE="dev" #Default the Dev file to be used

    # Set up our structure for our re-used commands
    COMPOSE="docker compose -f docker-compose.yml -f docker-compose.$COMPOSE_FILE.yml"

    # Check that an argument is passed
    if [ $# -gt 0 ]; then
        # Check the first argument and pass the user to proper action,
        # Only some actions need arguments passed.
        case $1 in
            exec)
                action_exec "$@"
            ;;
            a)
                action_artisan "$@"
            ;;
            artisan)
                action_artisan "$@"
            ;;
            composer)
                action_composer "$@"
            ;;
            node)
                action_node "$@"
            ;;
            up)
                action_up "$@"
            ;;
            uphmr)
                action_up_hmr "$@"
            ;;
            down)
                action_down "$@"
            ;;
            install)
                action_install
            ;;
            *)
                echo "\"$1\" is not a valid command."
            ;;
        esac
    else
        echo "Command not defined"
    fi
}

main "$@"
