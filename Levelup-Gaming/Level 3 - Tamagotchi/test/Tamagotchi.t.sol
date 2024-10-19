// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Tamagotchi.sol";

contract TamagotchiTest is Test {
    Tamagotchi public tamagotchi;
    address public owner = address(1);

    function setUp() public {
        vm.prank(owner);
        tamagotchi = new Tamagotchi();
    }

    function testCreatePet() public {
        vm.prank(owner);
        tamagotchi.createPet("TestPet");
        
        (string memory name, uint256 hunger, uint256 happiness, uint256 health, uint256 lastInteraction, uint256 age) = tamagotchi.getPetStatus();
        assertEq(name, "TestPet");
        assertEq(hunger, 50);
        assertEq(happiness, 50);
        assertEq(health, 100);
        assertGt(lastInteraction, 0);
        assertEq(age, 0);
    }

    function testFeed() public {
        vm.prank(owner);
        tamagotchi.createPet("TestPet");
        
        vm.warp(block.timestamp + 1 hours);
        
        vm.prank(owner);
        tamagotchi.feed();
        
        (,uint256 hunger,,,,) = tamagotchi.getPetStatus();
        assertLt(hunger, 50);
    }

    function testPlay() public {
        vm.prank(owner);
        tamagotchi.createPet("TestPet");
        
        vm.warp(block.timestamp + 1 hours);
        
        vm.prank(owner);
        tamagotchi.play();
        
        (,, uint256 happiness,,,) = tamagotchi.getPetStatus();
        assertGt(happiness, 50);
    }

    function testUpdateStatus() public {
        vm.prank(owner);
        tamagotchi.createPet("TestPet");
        
        vm.warp(block.timestamp + 1 days);
        
        vm.prank(owner);
        tamagotchi.updateStatus();
        
        (,uint256 hunger, uint256 happiness, uint256 health,, uint256 age) = tamagotchi.getPetStatus();
        assertGt(hunger, 50);
        assertLt(happiness, 50);
        assertLt(health, 100);
        assertEq(age, 1);
    }

    function testOnlyOwnerCanInteract() public {
        vm.prank(owner);
        tamagotchi.createPet("TestPet");
        
        address nonOwner = address(2);
        vm.prank(nonOwner);
        vm.expectRevert("Only the pet owner can perform this action");
        tamagotchi.feed();
    }
}
