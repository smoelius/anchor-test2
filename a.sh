#! /bin/bash

set -xe

which solana-test-validator

cd foo

yarn

rm -rf test-ledger

rm -f target/deploy/foo-keypair.json

anchor keys sync

anchor build

PUBKEY="$(solana-keygen pubkey target/deploy/foo-keypair.json)"

RUST_LOG=debug "solana-test-validator" \
    "--ledger" \
    "test-ledger" \
    "--bpf-program" \
    "$PUBKEY" \
    "target/deploy/foo.so" &

anchor test --skip-deploy --skip-local-validator || true

kill %%

ls -l test-ledger

cat test-ledger/validator-*.log | grep DEBUG
