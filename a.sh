#! /bin/bash

set -xe

which solana-test-validator

rm -rf test-ledger

rm -f foo/target/deploy/foo-keypair.json

pushd foo && yarn && anchor keys sync && anchor build && popd

PUBKEY="$(solana-keygen pubkey foo/target/deploy/foo-keypair.json)"

RUST_LOG=debug "solana-test-validator" \
    "--ledger" \
    "test-ledger" \
    "--bpf-program" \
    "$PUBKEY" \
    "foo/target/deploy/foo.so" &

pushd foo

anchor test --skip-deploy --skip-local-validator || true

kill %%

ls -l ../test-ledger

cat ../test-ledger/validator-*.log | grep DEBUG

popd
