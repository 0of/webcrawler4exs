use Mix.Config

config :sugar, router: Gatherer.Router

config :sugar, Gatherer.Router,
  http: [
    port: 80
  ],
  https: false

config :db, name: "pages", host: "localhost", port: 28015