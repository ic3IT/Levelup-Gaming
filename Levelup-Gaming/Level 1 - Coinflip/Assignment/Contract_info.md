# CoinFlip Contract Development Hints

When developing your CoinFlip smart contract, consider the following aspects:

1. **State Variables**
   - `uint256 public constant MINIMUM_BET`: Define the minimum bet amount in wei

2. **Key Functions**
   - `flipCoin(bool _betOnHeads) external payable`: Main function to place a bet and flip the coin
   - `receive() external payable`: Allow the contract to receive Ether

3. **Events**
   - `CoinFlipped(address player, bool betOnHeads, bool result, uint256 amountWon)`

4. **Pseudo-Random Number Generation**
   - Generate a boolean result using a basic pseudo-random method
   - Be aware this method is not secure for production use (we'll be using VRF in the future)

5. **Game Logic**
   - Player wins if their bet (heads or tails) matches the result
   - Winning payout is double the bet amount

6. **Error Handling**
   - Use `require` statements to enforce minimum bet amount
   - Ensure the contract has enough balance to pay out winnings

7. **Security Considerations**
   - Be aware of the limitations of using basic pseudo-random generation
   - Implement measures to prevent contract balance manipulation

8. **Gas Optimization**
   - Minimize storage operations
   - Use `view` and `pure` function modifiers where appropriate

Remember to thoroughly test all functions and edge cases, particularly the randomness and payout logic. Also, consider discussing how this implementation could be improved for a production environment, such as using a more secure randomness source like Chainlink VRF.
