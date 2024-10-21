// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleRaffle is Ownable {
    uint256 public ticketPrice;
    address[] public participants;

    constructor(uint256 _ticketPrice) Ownable(msg.sender) {
        ticketPrice = _ticketPrice;
    }

    function buyTicket() external payable {
        require(msg.value == ticketPrice, "Incorrect ticket price");
        participants.push(msg.sender);
    }

    function drawWinner() external onlyOwner returns (address) {
        require(participants.length > 0, "No participants");
        uint256 winnerIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % participants.length;
        address winner = participants[winnerIndex];
        participants = new address[](0);
        return winner;
    }

    function getParticipantsCount() public view returns (uint256) {
        return participants.length;
    }
}
