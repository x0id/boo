defmodule Boo.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {GRPC.Server.Supervisor, endpoint: Boo.Endpoint, port: 50051, start_server: true}
    ]

    opts = [strategy: :one_for_one, name: Boo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
