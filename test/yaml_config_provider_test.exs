defmodule YamlConfigProviderTest do
  use ExUnit.Case
  doctest YamlConfigProvider
  require Logger

  test "yaml read test" do
    res = YamlElixir.read_from_file!("test/test1.yml")
    # res = map_t(res)

    
    # IO.inspect(res, width: 40)
    # throw(res)

    config=[yaml_config_provider: [json_library: Jason, collectors: [], host: {:system, "NATS_HOST", "localhost"}, port: {:system, :integer, "NATS_PORT", 4222}, default_signer: "uibyuvyctrrgyugiuhiuhiuhih"], elixir: [config_providers: :booted], kernel: [start_distribution: true]]

    IO.inspect(config, width: 40)

    IO.inspect(">>>>>>>>>>>>>>>")

    config_map = proplist2map(config)

    IO.inspect(config_map, width: 40)

  end

  def proplist2map(list) do
    list
      |> Enum.reduce(%{}, fn(x, acc) ->

        Logger.debug ">>> x=#{inspect x}"

        acc
      end)
  end
end
