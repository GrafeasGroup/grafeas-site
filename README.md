# Grafeas Group, Ltd. (the site)

This is the project source code of https://www.grafeas.org/

## Requirements

- NodeJS (v8.x or latest LTS)
- Ruby (v2.4.2)
- Bundler (v1.16.x)

```
$ bundle install
$ npm install
```

## Build

```
$ bundle exec middleman build
```

## View

```
$ ruby -run -ehttpd build/ -p8000
```

Open a browser to http://localhost:8000/
