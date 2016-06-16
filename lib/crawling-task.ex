defmodule CrawlingTask do
	#
  # start the web page processing container
  #
  def run(url) do
    load_url_env = Enum.join(["LOAD_URL", url], "=")

    System.cmd("docker", ["run",
                          "--read-only", "-v", "/opt/electron/electron:/", "/opt/pagep/:/",
                          "--env", load_url_env])
  end
end