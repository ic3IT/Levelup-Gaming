// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/CoinFlip.sol";

contract CoinFlipTest is Test {
    CoinFlip public coinFlip;
    address public player = address(1);
    uint256 public constant MINIMUM_BET = 0.01 ether;

    function setUp() public {
        coinFlip = new CoinFlip();
        vm.deal(player, 1 ether);
        vm.deal(address(coinFlip), 1 ether); 
    }

    function testMinimumBet() public {
        vm.prank(player);
        vm.expectRevert("Bet amount too low");
        coinFlip.flipCoin{value: MINIMUM_BET - 1}(true);
    }

    function testFlipCoin() public {
        uint256 initialPlayerBalance = player.balance;
        uint256 initialContractBalance = address(coinFlip).balance;

        vm.prank(player);
        coinFlip.flipCoin{value: MINIMUM_BET}(true);

        assertTrue(
            player.balance == initialPlayerBalance + MINIMUM_BET || // Won
            player.balance == initialPlayerBalance - MINIMUM_BET,   // Lost
            "Unexpected balance change"
        );

        assertTrue(
            address(coinFlip).balance == initialContractBalance - MINIMUM_BET || // Player won
            address(coinFlip).balance == initialContractBalance + MINIMUM_BET,   // Player lost
            "Unexpected contract balance change"
        );
    }

    function testReceiveFunction() public {
        uint256 initialBalance = address(coinFlip).balance;
        payable(address(coinFlip)).transfer(1 ether);
        assertEq(address(coinFlip).balance, initialBalance + 1 ether, "Contract should receive Ether");
    }

    receive() external payable {}
}
