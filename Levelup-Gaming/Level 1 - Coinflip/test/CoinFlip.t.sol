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
        vm.deal(player, 10 ether);
    }

    function testMinimumBet() public {
        vm.prank(player);
        vm.expectRevert("Bet amount too low");
        coinFlip.flipCoin{value: MINIMUM_BET - 1}(true);
    }

    function testFlipCoin() public {
        vm.prank(player);
        coinFlip.flipCoin{value: MINIMUM_BET}(true);
        
        assertEq(address(coinFlip).balance, MINIMUM_BET);
    }

    // Add other test functions...
}
