// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract CoinFlip {
    // Define a constant for the minimum bet amount
    // TODO: Set an appropriate minimum bet (e.g., 0.01 ether)

    // Define an event for when a coin flip is completed
    // TODO: Create an event called CoinFlipped with appropriate parameters

    // Implement the flip function
    function flipCoin(bool _betOnHeads) external payable {
        // TODO: Ensure the bet meets the minimum amount
        // Hint: Use require() to check if msg.value >= MINIMUM_BET

        // Generate a pseudo-random boolean for the flip result
        bool result = random() % 2 == 0;
        // Note: This method is not secure for production use.
        // In the future, we'll implement a more secure solution using VRF (Verifiable Random Function).

        // TODO: Determine if the player won
        // Hint: Compare result with _betOnHeads

        // TODO: Calculate the payout
        // Hint: If player won, payout should be double their bet

        // TODO: Emit the result event
        // Hint: Use the event you defined earlier

        // TODO: Transfer the payout to the player if they won
        // Hint: Use address(this).balance to check if the contract has enough funds
        // If the player won, use payable(msg.sender).transfer() to send the payout
    }

    // This function generates a pseudo-random number
    function random() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, block.number, msg.sender)));
    }

    // TODO: Implement a function to allow the contract to receive Ether
    // Hint: Use the receive() function

    // TODO: Implement a function to allow the owner to withdraw the Ether
    // Hint: use onlyOwner
}

