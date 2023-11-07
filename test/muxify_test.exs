defmodule MuxifyTest do
  use ExUnit.Case
  doctest Muxify

  test "muxify converts HLS to MP4" do
    # Set up the test data
    hls_file = Path.join([__DIR__, "master.m3u8"])

    # Call the function being tested
    mp4_file = Muxify.muxify(hls_file)

    # Check the result
    assert File.exists?(mp4_file)
  end
end