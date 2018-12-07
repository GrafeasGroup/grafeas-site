# Grafeas Group, Ltd. (the site)

This is the project source code of https://www.grafeas.org/

## Requirements

- NodeJS (v8.x or latest LTS)
- Ruby (v2.4.2 or later)
- Bundler (v1.16.x or later)

## MacOS-specific quick start

```shell
$ brew install node
$ brew install libsass

# Note: chruby does not play nicely with some shells (e.g., fish); may need to stick with bash, zsh, or find a specific fix for your shell.
$ brew install chruby
$ brew install ruby-install

# this may take a while
$ ruby-install ruby 2.5.1
```

RESTART YOUR SESSION. This next step will not work until you reload your dotfiles (just close your terminal session and restart it, it's faster.)

```shell
$ chruby 2.5.1
$ gem install bundler

$ bundle install
$ npm install
```

`npm` install _may_ choke on the installation of `node-sass`. This is a known issue with MacOS and has historically caused us pains. Here is what has worked in many cases:

1. Be sure to have `libsass` installed (`brew install libsass`)
2. remove the `node_modules/` directory then try again

These 2 actions will usually resolve the errors with `npm install` enough to let the process continue.

## Development

When you want to work on the site, navigate to the project directory and run:

```shell
$ chruby 2.5.1
```

...in order to set the appropriate Ruby environment. After making any changes to the content, run...

```shell
$ bundle exec middleman build
```

... to compile the static site so that it can be served. In a different window, you can run...

```
$ ruby -run -ehttpd build/ -p8000
```

...to serve the local version of the site. It can be reached at http://localhost:8000/.

In order to work on the `/give` pages, please contact @itsthejoker for access to the accompanying Python server and testing keys for Stripe.
