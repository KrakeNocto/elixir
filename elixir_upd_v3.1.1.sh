#!/bin/bash

sleep 43200

min_am=600
max_am=43200
random_am=$(shuf -i $min_am-$max_am -n 1)

echo "Updating Elixir validator after $random_am seconds"

sleep $random_am

docker kill elixir
docker rm elixir

docker pull elixirprotocol/validator:v3 --platform linux/amd64

docker run -d \
  --env-file /root/.elixir/validator.env \
  --name elixir \
  -p 17690:17690 \
  --restart unless-stopped \
  elixirprotocol/validator:3.4.7

rm elixir_upd_v3.1.1.sh

docker logs -f elixir
