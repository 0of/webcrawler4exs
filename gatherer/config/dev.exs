use Mix.Config

config :sugar, router: Gatherer.Router

config :sugar, Gatherer.Router,
  http: [
    port: 80
  ],
  https: false

config :db, host: "localhost", port: 28015