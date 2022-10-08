#!/usr/bin/env bash

BINARY=evmosd
DENOM='aevmos'
CHAINID="evmos_9000-1"
RPC='http://localhost:26657/'
TXFLAG="--gas-prices 1$DENOM --gas auto --gas-adjustment 1.3 -y -b block --chain-id $CHAIN_ID --node $RPC"

CONTRACT_ADDRESS="evmos1zwv6feuzhy6a9wekh96cd57lsarmqlwxdypdsplw6zhfncqw6ftq65a4u6"

# Query contract metadata
CONTRACT_STATE=$($BINARY query wasm contract-state all $CONTRACT_ADDRESS --output json)
echo "Contract state: $CONTRACT_STATE"

# Query the self delegate balance
SELF_BALANCE=$($BINARY query wasm contract-state smart $CONTRACT_ADDRESS '{"balance":{"address":"evmos1wmxwr4lh4efq85j56plmcxlvjkyk6fcmemf0uk"}}' -b block --output json) 
echo "Self balance: $SELF_BALANCE"
