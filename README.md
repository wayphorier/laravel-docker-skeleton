# Laravel App Docker Skeleton

## Remove `.git` directory

Since it's just a starter template you need to init your own git repository:

```bash
rm -rf .git && git init .
```

## Configure Docker Compose's .env file

Create your own one from example:

```bash
cp .env.example .env
```

Set up your Laravel service domain, database name and credentials, etc.


*Do not confuse this one with another in Laravel installation folder!*

## Install Laravel

```bash
./xc install
```

## Configure Laravel's .env

* `APP_URL` - same as `APP_URL` from the Docker Compose's `.env` file
* `DB_HOST` - your docker-compose database service name (`mysql` by default)
* other database-related variables - same as from Docker Compose's `.env` ones

## Start Docker services

*with automatic assets compiling and frontend hot reloading:*
```bash
./xc -f docker-compose.hmr.dev.yml up
```
*without assets compiling and HMR:*

```bash
./xc up
```

You can use any of the docker compose commands parameters with `./xc`. For example, to run Laravel app in detached mode:

```bash
./xc up -d
```

## Artisan

You can run any artisan command with `./xc artisan {command}`, e.g.:

```bash
./xc artisan make:controller UploadController
```

*Before you run artisan command, make sure that Laravel's service is running.*

## Migrations

Run migrations

```bash
./xc artisan migrate
```

## Composer

You can run any composer command with `./xc composer {command}`, e.g.:

```bash
./xc composer require nunomaduro/phpinsights --dev
```

## Node.js

Your can run any Node.js command witn `./xc node {command}`. Note that `node` is a Docker Compose's service name, you shouls always preface Node.js commands with it. Examples:

**Install dependencies:**
```bash
./xc node npm install
```

**Build assets:**
```bash
./xc node npm run build
```
