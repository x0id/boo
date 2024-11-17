defmodule Boo.MixProject do
  use Mix.Project

  def project do
    [
      app: :boo,
      version: "0.1.0",
      elixir: "~> 1.17",
      erlc_options: erl_opts(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Boo.Application, []}
    ]
  end

  defp erl_opts, do: [warnings_as_errors: true]

  defp deps do
    [
      {:grpc, "~> 0.9"},
      {:spec, app: false, path: "spec", compile: compile_spec()}
    ]
  end

  def releases, do: [boo: [include_executables_for: [:unix]]]

  defp compile_spec do
    cmd = "protoc --elixir_out=plugins=grpc:../lib boo.proto"

    src = "spec/boo.proto"
    dst = "lib/boo.pb.ex"

    with {:ok, %File.Stat{mtime: src_mtime}} <- File.lstat(src),
         {:ok, %File.Stat{mtime: dst_mtime}} <- File.lstat(dst) do
      if src_mtime > dst_mtime do
        "echo 'Recompiling #{src}'; " <> cmd
      else
        false
      end
    else
      {:error, :enoent} ->
        "echo 'Compiling #{src}'; " <> cmd

      {:error, error} ->
        Mix.raise("#{src}: #{error}")
    end
  end
end
