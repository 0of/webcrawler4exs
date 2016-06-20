defmodule FailureGatherer do
  use Sugar.Controller

  def fail(conn, _) do
    %{"key" => key, "host" => host, "reason" => reason} = conn.params
    IO.inspect key

    json conn, %{status: "ok"}
  end
end