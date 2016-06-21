defmodule Gatherer do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
    	worker(RethinkDB.Connection, [[name: Application.fetch_env!(:db, :name), host: 'localhost', port: 28015]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gatherer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
