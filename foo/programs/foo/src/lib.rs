use anchor_lang::prelude::*;

declare_id!("3iKntdewJB8veY52mGrVMqLcAvBDgpGuPt7Ay1y6U3XU");

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
