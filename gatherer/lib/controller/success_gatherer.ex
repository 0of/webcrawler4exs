defmodule SuccessGatherer do
  use Sugar.Controller

  def succeed(conn, _) do
    %{"key" => key, "host" => host} = conn.params
    IO.inspect key

    json conn, %{status: "ok"}
  end
end