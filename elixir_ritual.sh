# Ставим докер, проверяем "docker ps"

# Для валидатора создаем чистый кошелек, скачиваем на сервер файл конфига и заполняем его

wget https://files.elixir.finance/validator.env /home/ritual/

echo "Enter private key:"
read -r PK
echo "Enter Val address:"
read -r VADDR
echo "Enter Moniker:"
read -r MONIKER

# Заполняем файл конфига
sed -i.bak -e "s|^STRATEGY_EXECUTOR_IP_ADDRESS=.*|STRATEGY_EXECUTOR_IP_ADDRESS=$(curl -s 2ip.ru)|" \
           -e "s|^STRATEGY_EXECUTOR_DISPLAY_NAME=.*|STRATEGY_EXECUTOR_DISPLAY_NAME=${MONIKER}|" \
           -e "s|^STRATEGY_EXECUTOR_BENEFICIARY=.*|STRATEGY_EXECUTOR_BENEFICIARY=${VADDR}|" \
           -e "s|^SIGNER_PRIVATE_KEY=.*|SIGNER_PRIVATE_KEY=${PK}|" $HOME/validator.env

# Дальше берем ещё один чистый кошелек, дергаем кран Sepolia
# Переходим сюда https://testnet-3.elixir.xyz/
# Подключаем кошелек Metamask
# Жмем MINT 1000 MOCK
# Затем аппруваем использование 1000 MOCK
# Затем стейкаем 1000 MOCK, все транзакции будут валидироваться какое-то время

# Дальше жмем CUSTOM VALIDATOR и в появившемся окне вводим адрес валидатора, который вписывали в конфиг и жмем DELEGATE

# Создаем папку .elixir и закидываем файл конфига
mkdir -p /home/ritual/.elixir
mv /home/ritual/validator.env /home/ritual/.elixir/validator.env

# Download the Docker image for the Testnet v3 validator by running the following docker command:
docker pull elixirprotocol/validator:3.4.6

# Start Your Validator:
docker run -d \
  --env-file /home/ritual/.elixir/validator.env \
  --name elixir \
  -p 17690:17690 \
  --restart unless-stopped \
  elixirprotocol/validator:3.4.6

  rm elixir_ritual.sh

  docker logs -f elixir
