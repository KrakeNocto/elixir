#!/bin/bash

docker kill elixir
docker rm elixir

docker run -d \
  --env-file /root/.elixir/validator.env \
  --name elixir \
  -p 17690:17690 \
  --restart unless-stopped \
  elixirprotocol/validator:3.1.1

rm elixir_upd_v3.1.1.sh

docker logs -f elixir