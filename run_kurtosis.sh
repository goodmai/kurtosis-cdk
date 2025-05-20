#!/bin/bash
#STAGE1
# Clean up all Kurtosis enclaves
kurtosis clean --all

# Run the Kurtosis enclave named 'cdk'
kurtosis run --enclave cdk .
kurtosis enclave inspect cdk
# Assign the RPC URL of the cdk-erigon-rpc-001 service in the cdk enclave to ETH_RPC_URL
ETH_RPC_URL=$(kurtosis port print cdk cdk-erigon-rpc-001 rpc)

# Call the specified contract address with the given data
a1=cast call --rpc-url "$ETH_RPC_URL" "0x0000000000000000000000000000000000000002" "0x0123"

# Compute the keccak hash of the input data using a private key
a2=cast keccak 0123
diff -u <(echo "$a1") <(echo "$a2")
