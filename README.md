
# Get protoc (platform-dependent)
```
wget https://github.com/protocolbuffers/protobuf/releases/download/v28.3/protoc-28.3-osx-aarch_64.zip
unzip ...
```
Ensure protoc in the PATH.

# Dependencies
```
mix deps.get
mix deps.compile
mix escript.install hex protobuf
```
Add ~/.mix/escripts to the PATH.

# Build service
```
mix compile
MIX_ENV=prod mix release
```

# Run service
```
_build/prod/rel/boo/bin/boo start
```

# Python client example

```
docker build client -t boo-client

docker run --rm -it -v $PWD:/app -w /app boo-client python -m grpc_tools.protoc \
-I spec --python_out=client --grpc_python_out=client boo.proto

docker run --rm -it -v $PWD/client:/app -w /app --network host boo-client python query.py
```

Result:
```
msg: "\'hello\' from #PID<0.1104.0>"
```
