#!/bin/bash

echo "Sleeping 0 seconds"

sleep 0

min_am=600
max_am=172800
random_am=$(shuf -i $min_am-$max_am -n 1)

echo "Updating Elixir validator after $random_am seconds"

sleep $random_am

docker kill elixir
docker rm elixir

docker pull elixirprotocol/validator:testnet --platform linux/amd64

docker run -d \
  --env-file /home/ritual/.elixir/validator.env \
  --name elixir \
  -p 17690:17690 \
  --restart unless-stopped \
  elixirprotocol/validator:testnet

rm elixir_upd_ritual.sh

docker logs -f elixir
