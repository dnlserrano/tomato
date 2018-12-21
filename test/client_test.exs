defmodule Tomato.ClientTest do
  import Mox
  use ExUnit.Case, async: true

  @subject Tomato.Client

  @http_client Application.get_env(:tomato, :http_client)

  @path "/restaurants"
  @json %{"restaurant" => "Valdo Gatti"}
  @not_found %{"error" => "Not Found"}

  describe "get/2" do
    test "returns error tuple when response is an error with a reason" do
      expected_uri = expected_uri()

      expect(@http_client, :get, fn ^expected_uri, _headers, _opts ->
        {:error, %HTTPoison.Error{id: nil, reason: :econnrefused}}
      end)

      assert {:error, :econnrefused} == @subject.get(@path)
    end

    test "returns error tuple when response is weird" do
      expected_uri = expected_uri()

      expect(@http_client, :get, fn ^expected_uri, _headers, _opts ->
        {:error, "bork!"}
      end)

      assert {:error, :unexpected_error} == @subject.get(@path)
    end

    test "returns ok tuple when response status is ok" do
      expected_uri = expected_uri()

      expect(@http_client, :get, fn ^expected_uri, _headers, _opts ->
        {:ok, %HTTPoison.Response{status_code: 200, body: Poison.encode!(@json)}}
      end)

      assert {:ok, @json} == @subject.get(@path)
    end

    test "returns error tuple when response status is not ok" do
      expected_uri = expected_uri()

      expect(@http_client, :get, fn ^expected_uri, _headers, _opts ->
        {:ok, %HTTPoison.Response{status_code: 404, body: Poison.encode!(@not_found)}}
      end)

      assert {:error, @not_found} == @subject.get(@path)
    end

    test "sets the right headers" do
      expected_headers = expected_headers()

      expect(@http_client, :get, fn _uri, ^expected_headers, _opts ->
        {:ok, %HTTPoison.Response{status_code: 404, body: Poison.encode!(@not_found)}}
      end)

      @subject.get(@path)
    end

    test "correctly encodes options as query parameters" do
      expected_opts = [params: [cuisine: "Italian"]]

      expect(@http_client, :get, fn _uri, _headers, ^expected_opts ->
        {:ok, %HTTPoison.Response{status_code: 404, body: Poison.encode!(@not_found)}}
      end)

      @subject.get(@path, [city: "", country: nil, cuisine: "Italian"])
    end
  end

  defp expected_uri do
    Application.get_env(:tomato, :zomato_api_uri)
    |> URI.merge(@path)
    |> URI.to_string()
  end

  defp expected_headers do
    [
      {"Accept", "application/json"},
      {"X-Zomato-API-Key", Application.get_env(:tomato, :zomato_api_key)}
    ]
  end
end
