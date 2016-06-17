ExUnit.start

Mix.Task.run "ecto.create", ~w(-r CrawlingGatherer.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r CrawlingGatherer.Repo --quiet)


