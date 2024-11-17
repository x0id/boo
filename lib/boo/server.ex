defmodule Boo.Server do
  use GRPC.Server, service: Boo.Echo.Service

  def ping(%Boo.PingMsg{msg: msg}, _) do
    %Boo.PongMsg{msg: "'#{msg}' from #{inspect(self())}"}
  end
end
