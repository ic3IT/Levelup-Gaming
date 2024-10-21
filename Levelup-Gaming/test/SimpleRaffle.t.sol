// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/SimpleRaffle.sol";

contract SimpleRaffleTest is Test {
    SimpleRaffle public raffle;
    address public owner = address(1);
    address public player1 = address(2);
    address public player2 = address(3);
    uint256 public constant TICKET_PRICE = 0.1 ether;

    function setUp() public {
        vm.prank(owner);
        raffle = new SimpleRaffle(TICKET_PRICE);
        vm.deal(player1, 1 ether);
        vm.deal(player2, 1 ether);
    }

    function testBuyTicket() public {
        vm.prank(player1);
        raffle.buyTicket{value: TICKET_PRICE}();
        assertEq(raffle.getParticipantsCount(), 1);
    }

    function testBuyTicketInsufficientFunds() public {
        vm.prank(player1);
        vm.expectRevert("Incorrect ticket price");
        raffle.buyTicket{value: TICKET_PRICE - 1}();
    }

    function testDrawWinner() public {
        // Buy tickets
        vm.prank(player1);
        raffle.buyTicket{value: TICKET_PRICE}();
        vm.prank(player2);
        raffle.buyTicket{value: TICKET_PRICE}();

        // Draw winner
        vm.prank(owner);
        address winner = raffle.drawWinner();

        // Check if the winner is one of the participants
        assertTrue(winner == player1 || winner == player2, "Winner should be one of the participants");

        // Check if the participants list is reset
        assertEq(raffle.getParticipantsCount(), 0, "Participants list should be reset after drawing a winner");
    }

    function testDrawWinnerUnauthorized() public {
        vm.prank(player1);
        vm.expectRevert(abi.encodeWithSignature("OwnableUnauthorizedAccount(address)", player1));
        raffle.drawWinner();
    }

    function testDrawWinnerNoParticipants() public {
        vm.prank(owner);
        vm.expectRevert("No participants");
        raffle.drawWinner();
    }
}
