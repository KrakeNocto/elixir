#!/bin/bash

docker kill elixir
docker rm elixir

docker pull elixirprotocol/validator:v3 --platform linux/amd64

docker run -d \
  --env-file /home/ritual/.elixir/validator.env \
  --name elixir \
  -p 17690:17690 \
  --restart unless-stopped \
  elixirprotocol/validator:3.4.6

rm elixir_upd_ritual.sh

docker logs -f elixir