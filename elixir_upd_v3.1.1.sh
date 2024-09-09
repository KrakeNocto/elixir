#!/bin/bash

docker kill elixir
docker rm elixir

docker pull elixirprotocol/validator:v3 --platform linux/amd64

docker run -d \
  --env-file /root/.elixir/validator.env \
  --name elixir \
  -p 17690:17690 \
  --restart unless-stopped \
  elixirprotocol/validator:3.4.0

rm elixir_upd_v3.1.1.sh

docker logs -f elixir
