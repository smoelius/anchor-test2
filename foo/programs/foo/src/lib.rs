use anchor_lang::prelude::*;

declare_id!("CSQcFSaAtz6pkTbAX2t28iJpHarNggLw9CsS6f2R8Sme");

#[program]
pub mod foo {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>) -> Result<()> {
        msg!("Greetings from: {:?}", ctx.program_id);
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize {}
