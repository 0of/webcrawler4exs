defmodule CrawlingTask do
	#
  # start the web page processing container
  #
  def run(url) do
    load_url_env = String.join(["LOAD_URL", url], "=")

    command = String.join(["docker", "run",
                           "--read-only", "-v", "/opt/electron/electron:/", "/opt/pagep/:/",
                           "--env", load_url_env], " ")
    System.cmd(command)
  end
end