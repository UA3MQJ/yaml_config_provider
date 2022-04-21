defmodule YamlConfigProvider.Test.Module do
  def test, do: :ok
end

defmodule YamlConfigProvider do
  @behaviour Config.Provider
  @env Mix.env()
  require Logger

  def env, do: @env

  def init(opts) do
    Logger.debug ">>>> init opts=#{inspect opts}"
    # otp_app = Keyword.fetch!(repo.config(), :otp_app)
    # env = Keyword.get(opts, :env, {:system, "ENV"})
    yml_config_file = Keyword.fetch!(opts, :yml_config_file)

    %{yml_config_file: yml_config_file}
  end

  def load(config, %{yml_config_file: yml_config_file}= opts) do
    {:ok, _} = Application.ensure_all_started(:logger)
    {:ok, _} = Application.ensure_all_started(:yaml_elixir)

    Logger.debug ">>>> opts=#{inspect opts}"
    Logger.debug ">>>> config=#{inspect config}"
    config_map = YamlElixir.read_from_file!(yml_config_file)
    config_map = map_t(config_map)
    Logger.debug ">>>> config_map=#{inspect config_map}"
    Logger.debug ">>>> env=#{inspect env()}"
    
    
    # We need to start any app we may depend on.

    config
  end

  def map_t(map) do
    map
      |> Enum.map(fn({k, v})->
        map_t_kv(k, v)
      end)
      |> Enum.into(%{})
  end

  defp map_t_kv(k, v) when is_map(v) do
    key_atom = String.to_atom(k)
    new_v = map_t(v)
    {key_atom, new_v}
  end
  defp map_t_kv(k, v) when is_binary(v) do
    key_atom = String.to_atom(k)
    new_v = safe_string_to_atom(v)
    {key_atom, new_v}
  end

  defp map_t_kv(k, v) do
    key_atom = String.to_atom(k)
    {key_atom, v}
  end

  defp safe_string_to_atom(value) do
    try do
      String.to_existing_atom(value)
    rescue
      ArgumentError -> value
    end
  end

end
