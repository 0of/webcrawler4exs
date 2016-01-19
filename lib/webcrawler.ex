defmodule Webcrawler do
  require Base
  require HTTPoison

  def start_crawling(url, sender) do
    spawn(__MODULE__, :loop, [url, sender])
  end

  def loop(url, sender) do
    HTTPoison.get! url, %{}, stream_to: self
    receive do
      %HTTPoison.AsyncStatus{:id => id, :code => status_code} when status_code == 200 ->
        :crypto.hash(:sha256, url) 
        |> Base.encode16
        |> (fn(encoded) -> %{:dev => (File.open!(encoded, [:write])), :id => encoded} end).() 
        |> (fn(storage) -> handling_request(storage, sender, id) end).()
      %HTTPoison.Error{:reason => reason} ->
        IO.puts(reason)
    end
  end

  defp handling_request(storage, sender, req_id) do
    receive do 
      %HTTPoison.AsyncChunk{:id => id, :chunk => chunk} when req_id == id ->
        raise_if_error(IO.binwrite(storage.dev, chunk))
        handling_request(storage, sender, req_id)
      %HTTPoison.AsyncEnd{:id => id} when req_id == id ->
        File.close(storage.dev)
        send(sender, {:ok, storage.id})
    end
  end

  defp raise_if_error({:error, term}), do: raise term
  defp raise_if_error(:ok), do: :ok
end
