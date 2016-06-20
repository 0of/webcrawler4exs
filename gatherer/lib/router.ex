defmodule Gatherer.Router do
  use Sugar.Router

  plug Sugar.Plugs.HotCodeReload

  post "/succeed", SuccessGatherer, :succeed
  post "/fail", FailureGatherer, :fail
end