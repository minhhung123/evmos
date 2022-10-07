package app

import (
	wasmkeeper "github.com/CosmWasm/wasmd/x/wasm/keeper"
)

const (
	// DefaultEvmosInstanceCost is initially set the same as in wasmd
	DefaultEvmosInstanceCost uint64 = 60_000
	// DefaultEvmosCompileCost set to a large number for testing
	DefaultEvmosCompileCost uint64 = 3
)

func EvmosGasRegisterConfig() wasmkeeper.WasmGasRegisterConfig {
	gasConfig := wasmkeeper.DefaultGasRegisterConfig()
	gasConfig.InstanceCost = DefaultEvmosInstanceCost
	gasConfig.CompileCost = DefaultEvmosCompileCost

	return gasConfig
}

func NewEvmosWasmGasRegister() wasmkeeper.WasmGasRegister {
	return wasmkeeper.NewWasmGasRegister(EvmosGasRegisterConfig())
}