#!/usr/bin/env bash

KEY="mykey"
CHAINID="evmos_9000-1"
MONIKER="localtestnet"
KEYRING="test" # remember to change to other types of keyring like 'file' in-case exposing to outside world, otherwise your balance will be wiped quickly. The keyring test does not require private key to steal tokens from you
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
#TRACE="--trace"
TRACE=""

BINARY=evmosd

CONTRACT_CODE=$($BINARY tx wasm store artifacts/cw_erc20-aarch64.wasm --from $KEY --keyring-backend=$KEYRING --gas-prices 1aevmos --gas auto --gas-adjustment 1.3 -y -b block --chain-id=$CHAINID --node=http://localhost:26657/  --output json | jq -r '.logs[0].events[-1].attributes[0].value')
echo "Stored: $CONTRACT_CODE"

INIT='{"name":"Hung Coin","symbol":"HUNG","decimals":6,"initial_balances":[{"address":"evmos1wmxwr4lh4efq85j56plmcxlvjkyk6fcmemf0uk","amount":"12345678000"}]}'

$BINARY tx wasm instantiate $CONTRACT_CODE "$INIT" --amount 50000aevmos --label "Hungcoin erc20" --from $KEY --keyring-backend=test --chain-id=$CHAINID --gas-prices 1aevmos --gas auto --gas-adjustment 1.3 -b block -y --no-admin

CONTRACT_ADDRESS=$($BINARY query wasm list-contract-by-code $CONTRACT_CODE --output json | jq -r '.contracts[-1]')
echo "Contract address: $CONTRACT_ADDRESS"