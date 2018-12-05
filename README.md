# Grafeas Group, Ltd. (the site)

This is the project source code of https://www.grafeas.org/

## Requirements

- NodeJS (v8.x or latest LTS)
- Ruby (v2.4.2)
- Bundler (v1.16.x)

## OSX-specific quick start

```
$ brew install npm

# Note: chruby does not play nicely with non-default shells; may need to stick with bash or find a specific fix for your shell.
$ brew install chruby ruby-install

# this may take a while
$ ruby-install ruby 2.4.2
```

RESTART YOUR SESSION. This next step will not work until you reload your dotfiles (just close your terminal session and restart it, it's faster.)

```
$ chruby 2.4.2
$ gem install bundler

$ bundle install
$ npm install
```

`npm` install _may_ choke on the installation of `node-sass`. This is a known issue with OSX and has historically caused us pains. Things to try to resolve this, in order:

1) install Xcode and try again
2) remove the node_modules folder and try again
3) remove the node_modules folder _and_ package-lock.json and try again

One of these three will usually resolve the errors with `npm install` enough to let the process continue.


## Development

When you want to work on the server, navigate to the project directory and run:

```
chruby 2.4.2
```

...in order to set the appropriate Ruby environment. After making any changes to the content, run...

```
$ bundle exec middleman build
```

... to compile the static site so that it can be served. In a different window, you can run...

```
$ ruby -run -ehttpd build/ -p8000
```

...to serve the local version of the site. It can be reached at http://localhost:8000/.

In order to work on the /give pages, please contact @itsthejoker for access to the accompanying Python server and testing keys for Stripe.
