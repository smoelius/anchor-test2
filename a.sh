#! /bin/bash

which solana-test-validator

rm -rf test-ledger

pushd foo && yarn && anchor build && popd

RUST_LOG=debug "solana-test-validator" \
    "--ledger" \
    "test-ledger" \
    "--bpf-program" \
    "3iKntdewJB8veY52mGrVMqLcAvBDgpGuPt7Ay1y6U3XU" \
    "foo/target/deploy/foo.so" &

pushd foo && anchor test --skip-deploy --skip-local-validator && popd

pkill test-validator

cat test-ledger/validator.log
