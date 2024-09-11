# Set up and usage | Laravel App Docker Skeleton

## Set root MySQL DB password in the .env file

```
DB_ROOT_PASSWORD=secret
```

## Install Laravel

```bash
./xc install
```

## Configure .env

* `DB_HOST` - your docker-compose database service name (`mysql` by default)
* other database-related variables

## Start Docker services

Without assets compiling and HMR:

```bash
./xc up
```

With automatic assets compiling and frontend hot reloading *(see [HMR setup instructions](#section-hmr) below)*:
```bash
./xc uphmr
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

<a id="section-hmr"></a>

## HMR (Hot Module Reloading) Setup

### 1. Add `server.hmr.host` property to Laravel's Vite config:

*laravel/vite.config.js*
```js
// ...

export default defineConfig({
    plugins: [
        // ...
    ],
    server: {
        hmr: {
            host: "localhost", // or "your-local-domain.test"
        },
    },
});
```

### 2. Add `@vite` directive to your Blade layout (e.g. before closing `head` tag):

*laravel/resources/vuews/layouts/main.blade.php*
```html
<!doctype html>
<head>
    {{-- ... --}}

    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
```

Source: [Laravel 10.x docs: Loading Your Scripts And Styles](https://laravel.com/docs/10.x/vite#loading-your-scripts-and-styles)
