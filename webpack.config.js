const webpack = require("webpack");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const Clean = require("clean-webpack-plugin");
const path = require("path");

let definePlugin = new webpack.DefinePlugin({
  __DEVELOPMENT__: JSON.stringify(JSON.parse(process.env.WEBPACK_ENV === "development")),
  __DEBUG__:       JSON.stringify(JSON.parse(process.env.WEBPACK_ENV === "debug")),
  __BUILD__:       JSON.stringify(JSON.parse(process.env.WEBPACK_ENV === "build")),
  __VERSION__:     (new Date().getTime().toString())
});
let extractSass = new ExtractTextPlugin("assets/stylesheets/[name].bundle.css");

let website = {
  entry: {
    index: [
      path.resolve(__dirname, "source", "assets", "javascripts", "index.js"),
      path.resolve(__dirname, "source", "assets", "stylesheets", "index.scss"),
    ],
    head: [
      path.resolve(__dirname, "source", "assets", "javascripts", "head.js"),
    ]
  },

  resolve: {
    modules: [
      path.resolve(__dirname, "source", "assets", "javascripts"),
      path.resolve(__dirname, "source", "assets", "stylesheets"),
      "node_modules"
    ]
  },

  output: {
    path: path.join(__dirname, ".tmp", "dist"),
    filename: path.join("assets", "javascripts", "[name].bundle.js")
  },

  module: {
    rules: [
      {
        test: /^(?!node_modules).+\.js/i,
        use: [
          {
            loader: "babel-loader",
            options: {
              presets: ["env", "es2015", "stage-0"]
            }
          }
        ]
      },
      {
        test: /^(?!node_modules).+\.s?css/i,
        use: extractSass.extract({
          use: [
            {
              loader: "css-loader",
              options: {
                sourceMap: true
              }
            },
            {
              loader: "sass-loader",
              options: {
                sourceMap: true
              }
            }
          ],
          fallback: "style-loader"
        })
      },
    ]
  },

  plugins: [
    definePlugin,
    new Clean([".tmp"]),
    extractSass
  ]
};

module.exports = website;
