defmodule LambdaElixirSample.MixProject do
  use Mix.Project

  def project do
    [
      app: :lambda_elixir_sample,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # Elixir for Lambda Application
      mod: {FaasBase.Aws.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Elixir for Lambda modules
      {:faas_base, "~> 1.0.2"},
      # utils
      {:json, "~> 1.4"},
      {:hackney, "~> 1.9"},
      {:sweet_xml, "~> 0.6"},
      {:poison, "~> 2.0"}
    ]
  end
end
