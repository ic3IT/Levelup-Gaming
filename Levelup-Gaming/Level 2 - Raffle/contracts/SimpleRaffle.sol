// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleRaffle {
    address public owner;
    uint256 public ticketPrice;
    address[] public participants;
    bool public raffleOpen;

    event TicketPurchased(address participant);
    event WinnerSelected(address winner, uint256 prize);
    event NewRaffleStarted();

    constructor(uint256 _ticketPrice) {
        owner = msg.sender;
        ticketPrice = _ticketPrice;
        raffleOpen = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function buyTicket() external payable {
        require(raffleOpen, "The raffle is not open");
        require(msg.value == ticketPrice, "Incorrect ticket price");

        participants.push(msg.sender);
        emit TicketPurchased(msg.sender);
    }

    function drawWinner() external onlyOwner {
        require(participants.length > 0, "No participants in the raffle");

        uint256 winnerIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % participants.length;
        address winner = participants[winnerIndex];
        uint256 prize = address(this).balance;

        payable(winner).transfer(prize);
        emit WinnerSelected(winner, prize);

        // Reset the raffle
        delete participants;
        raffleOpen = false;
    }

    function startNewRaffle() external onlyOwner {
        require(!raffleOpen, "A raffle is already open");
        delete participants;
        raffleOpen = true;
        emit NewRaffleStarted();
    }

    function getParticipantCount() external view returns (uint256) {
        return participants.length;
    }

    function changeTicketPrice(uint256 newPrice) external onlyOwner {
        require(!raffleOpen, "Cannot change ticket price while a raffle is open");
        ticketPrice = newPrice;
    }
}
