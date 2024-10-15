// import "@openzeppelin/contracts/access/Ownable.sol";

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract CoinFlip {
    // Define a constant for the minimum bet amount
    uint256 public constant MINIMUM_BET = 0.01 ether;

    // Define an event for when a coin flip is completed
    event CoinFlipped(address player, bool betOnHeads, bool result, uint256 amountWon);

    // Implement the flip function
    function flipCoin(bool _betOnHeads) external payable {
        // Ensure the bet meets the minimum amount
        require(msg.value >= MINIMUM_BET, "Bet amount must be at least the minimum bet");

        // Generate a pseudo-random boolean for the flip result
        bool result = random() % 2 == 0;
        // Note: This method is not secure for production use.
        // In the future, we'll implement a more secure solution using VRF (Verifiable Random Function).

        // Determine if the player won
        bool playerWon = (result == _betOnHeads);

        // Calculate the payout
        uint256 payout = playerWon ? msg.value * 2 : 0;

        // Emit the result event
        emit CoinFlipped(msg.sender, _betOnHeads, result, payout);

        // Transfer the payout to the player if they won
        if (playerWon) {
            require(address(this).balance >= payout, "Insufficient contract balance");
            payable(msg.sender).transfer(payout);
        }
    }

    // This function generates a pseudo-random number
    function random() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, block.number, msg.sender)));
    }

    // Implement a function to allow the contract to receive Ether
    receive() external payable {}

    // Add a function to allow the owner to withdraw excess funds
    // Note: In a real implementation, this should be restricted to the owner
    // function withdraw() external onlyOwner {
    //     payable(msg.sender).transfer(address(this).balance);
    // }
}
