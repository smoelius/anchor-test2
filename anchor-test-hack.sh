#! /bin/bash

set -xeuo pipefail

if [[ $# -ne 1 ]]; then
    echo "$0: expect one argument: program name" >&2
    exit 1
fi

PROGRAM="$1"

PUBKEY="$(grep "^$PROGRAM = \"[^\"]*\"$" Anchor.toml | grep -o '\"[^"]*\"' | grep -o '[^"]*')"

anchor build

rm -rf test-ledger

RUST_LOG=debug "solana-test-validator" \
    "--ledger" \
    "test-ledger" \
    "--bpf-program" \
    "$PUBKEY" \
    "target/deploy/$PROGRAM.so" &

set +e
anchor test --skip-deploy --skip-local-validator
STATUS=$?
set -e

kill %%

exit "$STATUS"
