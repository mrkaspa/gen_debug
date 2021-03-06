defmodule GenDebug.Mixfile do
  use Mix.Project

  def project do
    [app: :gen_debug,
     version: "0.1.0",
     elixir: "~> 1.3",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, "~> 0.12", only: :dev},
    ]
  end

  defp description do
    """
    GenDebug is a set of utilities to debug the state and messages of a GenServer
    """
  end

  defp package do
    [# These are the default files included in the package
      name: :gen_debug,
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Michel Perez"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/mrkaspa/gen_debug"}
    ]
  end
end
