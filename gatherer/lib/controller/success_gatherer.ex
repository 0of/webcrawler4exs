defmodule SuccessGatherer do
  use Sugar.Controller

  import RethinkDB.Query, only: [table_create: 1, table: 2, table: 1, insert: 2]

  def succeed(conn, _) do
    conn = RethinkDB.connect
    %{"key" => key, "host" => host} = conn.params
    IO.inspect key

    table_create("pages") |> RethinkDB.run conn

    json conn, %{status: "ok"}
  end
end