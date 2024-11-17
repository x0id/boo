defmodule Boo.Endpoint do
  use GRPC.Endpoint
  run(Boo.Server)
end
