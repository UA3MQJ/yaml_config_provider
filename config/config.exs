use Mix.Config

config :yaml_config_provider, :json_library, Jason

config :yaml_config_provider, collectors: []

config :yaml_config_provider,
  host: {:system, "NATS_HOST", "localhost"},
  port: {:system, :integer, "NATS_PORT", 4222}

config :yaml_config_provider, default_signer: "uibyuvyctrrgyugiuhiuhiuhih"

