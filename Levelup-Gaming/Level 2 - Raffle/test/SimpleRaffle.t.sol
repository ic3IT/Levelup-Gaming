// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../contracts/SimpleRaffle.sol";

contract SimpleRaffleTest {
    SimpleRaffle public raffle;
    address public owner;
    address public player1;
    address public player2;
    uint256 public constant TICKET_PRICE = 0.1 ether;

    constructor() {
        owner = address(this);
        player1 = address(0x1);
        player2 = address(0x2);
        raffle = new SimpleRaffle(TICKET_PRICE);
    }

    function testBuyTicket() public {
        raffle.buyTicket{value: TICKET_PRICE}();
        assert(raffle.getParticipantsCount() == 1);
    }

    function testBuyTicketInsufficientFunds() public {
        bool success = false;
        try raffle.buyTicket{value: TICKET_PRICE - 1}() {
            success = true;
        } catch {
            // Expected to fail
        }
        assert(!success);
    }

    function testDrawWinner() public {
        raffle.buyTicket{value: TICKET_PRICE}();
        address(player2).call{value: TICKET_PRICE}(
            abi.encodeWithSignature("buyTicket()")
        );

        address winner = raffle.drawWinner();
        assert(winner == player1 || winner == player2);
    }

    function testOnlyOwnerCanDrawWinner() public {
        bool success = false;
        try raffle.drawWinner() {
            success = true;
        } catch {
            // Expected to fail
        }
        assert(!success);
    }

    function testRaffleReset() public {
        raffle.buyTicket{value: TICKET_PRICE}();
        raffle.drawWinner();
        assert(raffle.getParticipantsCount() == 0);
    }

    receive() external payable {}
}
