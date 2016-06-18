defmodule CrawlingGatherer.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CrawlingGatherer do
    pipe_through :api
  end
end
