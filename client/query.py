#!/usr/bin/env python

import grpc
import boo_pb2
import boo_pb2_grpc

def main():
  host = 'host.docker.internal'
  port = '50051'

  with grpc.insecure_channel(f'{host}:{port}') as channel:
    stub = boo_pb2_grpc.EchoStub(channel)
    ping_msg = boo_pb2.PingMsg(msg = 'hello')
    response = stub.Ping(ping_msg)
    print(response)

if __name__ == '__main__':
   main()
