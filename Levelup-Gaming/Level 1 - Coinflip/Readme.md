# Level 1 - Coinflip

Hey there! Welcome to Level 1. We're kicking things off with a simple Coinflip game. Players can bet on heads or tails - nothing fancy, but it's a great starting point.

## What We're Aiming For

1. Build a basic CoinFlip contract
2. Get the hang of Ether transactions in smart contracts
3. Figure out how to generate pseudo-random numbers in Solidity (spoiler: it's tricky)
4. Set up a simple betting system with payouts

## Game Plan

1. Set up the contract:
   - Use the latest Solidity version
   - Define a minimum bet amount

2. Core game mechanics:
   - Create an event to log flip results
   - Build the main `flipCoin` function
   - Add a `receive` function so the contract can accept Ether

3. Betting logic:
   - Check if the bet meets the minimum
   - Generate a "random" result for the flip
   - Figure out if the player won and how much
   - Pay the winner (if there is one)

4. Pseudo-random number generation:
   - Mix some block data with user input for "randomness"
   - (Note: This isn't truly random or secure, but it'll do for now. We'll be switching to a VRF in the future.)

5. Events and error handling:
   - Emit events when flips happen
   - Use `require` statements to catch any weird inputs or situations

## Deployment

Throw this contract onto a testnet like Goerli or Sepolia when you're done.

Quick heads up: The random number generation we're using here isn't secure enough for real money. In a proper game, you'd want something more robust like a Verifiable Random Function (VRF).

Good luck! And hey, while you're building this, think about how you'd make it better for a real-world scenario. There's always room for improvement!
