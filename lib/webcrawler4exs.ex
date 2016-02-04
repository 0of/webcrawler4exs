defmodule Webcrawler4exs do
  use Application
  require Webcrawler

  def start(_, _) do
    start_endpoint()
  end

  def config_change(changed, _new, removed) do
    Webcrawler4exs.Endpoint.config_change(changed, removed)
    :ok
  end

  defp start_endpoint do
    import Supervisor.Spec, warn: false

    opts = [strategy: :one_for_one, name: Webcrawler4exs.Supervisor]
    Supervisor.start_link([supervisor(Webcrawler4exs.Endpoint, [])], opts)
  end

  defp start_crawling do
    Webcrawler.start_crawling("https://en.m.wikipedia.org/wiki/Main_Page", self)

    receive do
      {:ok, target} ->
        IO.puts(target)
    after
      10_000 -> IO.puts("uoops!")
    end
  end
end
