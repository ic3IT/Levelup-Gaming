# Level 1 - Coinflip

Welcome to Level 1, where we'll build a simple Coinflip game where the user can bet on either heads or tails.

## Objectives

1. Implement a basic CoinFlip contract
2. Learn about handling Ether transactions in smart contracts
3. Understand basic pseudo-random number generation in Solidity
4. Implement simple betting logic and payout mechanism

## Steps

1. Set up the contract structure
   - Define the contract with the appropriate Solidity version and license
   - Define state variables (MINIMUM_BET)

2. Implement core functionality
   - Create an event to log flip results
   - Implement the main `flipCoin` function
   - Add a `receive` function to accept Ether

3. Handle betting logic
   - Ensure the bet meets the minimum amount
   - Generate a pseudo-random result for the coin flip
   - Determine if the player won and calculate the payout
   - Transfer winnings to the player if they won

4. Implement basic pseudo-random number generation
   - Use a combination of block data and user input for randomness

5. Emit events and handle errors
   - Emit events for flip results
   - Use `require` statements to handle invalid inputs or conditions

## Deployment

- Deploy the contract to a testnet (e.g., Goerli or Sepolia)

Note: This implementation uses a basic pseudo-random number generation method, which is not secure for production use. In a real-world application, a more secure randomness source like VRF should be used.

Good luck with your implementation! Remember to consider the limitations of this basic approach and think about how it could be improved for a production environment.
