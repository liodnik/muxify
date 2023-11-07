defmodule Muxify do
  @moduledoc """
  Module implements POST and GET request to receive HLS file and send back MP4 file.
  """
  use Plug.Router

  plug :match
  plug :dispatch

  post "/hls-to-mp4" do
    # Get the HLS file from the request
    hls_file = get_req_param(conn, "hls_file")

    # Convert the HLS file to MP4
    mp4_file = muxify(hls_file)

    # Post back the MP4 file
    HTTPoison.post!("http://example.com/post-mp4-file", mp4_file)
  end

  defp get_req_param(conn, param_name) do
    case Plug.Conn.get_req_header(conn, "content-type") do
      "application/json" ->
        body = Poison.decode!(Plug.Conn.read_body(conn))
        Map.get(body, param_name)

      _ ->
        Plug.Conn.get_req_param(conn, param_name)
    end
  end

  def muxify(hls_file) do
    # Convert the HLS file to MP4
    mp4_file = System.cmd("ffmpeg", ["-i", hls_file, "-acodec", "copy", "-vcodec", "copy", "output.mp4"])

    # Return the MP4 file
    mp4_file
  end
end
