defmodule Webcrawler4exs do
  use Application
  require Webcrawler

  def start(_, _) do
    IO.puts("start to run...")
    Webcrawler.start_crawling("https://en.m.wikipedia.org/wiki/Main_Page", self)

    receive do
      {:ok, target} ->
        IO.puts(target)
    after
      10_000 -> IO.puts("uoops!")
    end    
  end
end
