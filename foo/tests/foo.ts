import * as anchor from "@coral-xyz/anchor";
import { Program } from "@coral-xyz/anchor";
import { Foo } from "../target/types/foo";

describe("foo", () => {
  // Configure the client to use the local cluster.
  anchor.setProvider(anchor.AnchorProvider.env());

  const program = anchor.workspace.foo as Program<Foo>;

  it("Is initialized!", async () => {
    if (process.env.SKIP_PREFLIGHT === "true") {
      while (null == await anchor.getProvider().connection.getAccountInfo(program.programId)) {
        await new Promise(resolve => setTimeout(resolve, 1000));
      }
    }
    
    // Add your test here.
    const tx = await program.methods.initialize().rpc();
    console.log("Your transaction signature", tx);
  });
});
