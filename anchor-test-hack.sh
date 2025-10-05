#! /bin/bash

set -xeuo pipefail

if [[ $# -ne 1 ]]; then
    echo "$0: expect one argument: program name" >&2
    exit 1
fi

PROGRAM="$1"

rm -f "target/deploy/$PROGRAM-keypair.json"

anchor keys sync

anchor build

PUBKEY="$(solana-keygen pubkey "target/deploy/$PROGRAM-keypair.json")"

rm -rf test-ledger

RUST_LOG=debug "solana-test-validator" \
    "--ledger" \
    "test-ledger" \
    "--bpf-program" \
    "$PUBKEY" \
    "target/deploy/$PROGRAM.so" &

anchor test --skip-deploy --skip-local-validator || true

kill %%
