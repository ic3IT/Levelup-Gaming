// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleRaffle {
    address public owner;
    uint256 public ticketPrice;
    address[] public participants;
    bool public raffleOpen;

    event TicketPurchased(address participant);
    event WinnerSelected(address winner, uint256 prize);

    constructor(uint256 _ticketPrice) {
        owner = msg.sender;
        ticketPrice = _ticketPrice;
        raffleOpen = true;
    }

    function buyTicket() external payable {
        // TODO: Ensure the raffle is open
        // Hint: Use require() to check if raffleOpen is true

        // TODO: Ensure the correct ticket price is paid
        // Hint: Use require() to check if msg.value == ticketPrice

        // TODO: Add the participant to the participants array
        // Hint: Use participants.push(msg.sender)

        // TODO: Emit the TicketPurchased event
        // Hint: Use emit TicketPurchased(msg.sender)
    }

    function drawWinner() external {
        // TODO: Ensure only the owner can call this function
        // Hint: Use require() to check if msg.sender == owner

        // TODO: Ensure there are participants in the raffle
        // Hint: Use require() to check if participants.length > 0

        // TODO: Select a winner
        // Hint: Use a simple method to generate a random index
        // uint256 winnerIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % participants.length;

        // TODO: Get the winner's address
        // Hint: Use participants[winnerIndex]

        // TODO: Calculate the prize (all the Ether in the contract)
        // Hint: Use address(this).balance

        // TODO: Transfer the prize to the winner
        // Hint: Use payable(winner).transfer(prize)

        // TODO: Emit the WinnerSelected event
        // Hint: Use emit WinnerSelected(winner, prize)

        // TODO: Reset the raffle
        // Hint: Clear the participants array and set raffleOpen to false
    }

    // TODO: Implement a function to allow the owner to start a new raffle
    // Hint: This function should reset the participants array and set raffleOpen to true

    // TODO: Implement any additional helper functions you might need
}
