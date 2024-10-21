// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Tamagotchi.sol";

contract TamagotchiTest is Test {
    Tamagotchi public tamagotchi;
    address public owner = address(1);
    address public otherUser = address(2);

    function setUp() public {
        tamagotchi = new Tamagotchi();
    }

    function testCreatePet() public {
        vm.prank(owner);
        tamagotchi.createPet("TestPet");
        
        (string memory name, uint256 hunger, uint256 happiness, uint256 health, uint256 lastInteraction, uint256 age) = tamagotchi.getPetStatus(owner);
        assertEq(name, "TestPet");
        assertEq(hunger, 50);
        assertEq(happiness, 50);
        assertEq(health, 100);
        assertGt(lastInteraction, 0);
        assertEq(age, 0);
    }

    function testCreatePetAlreadyExists() public {
        vm.startPrank(owner);
        tamagotchi.createPet("TestPet");
        vm.expectRevert("Pet already exists");
        tamagotchi.createPet("AnotherPet");
        vm.stopPrank();
    }

    function testFeed() public {
        vm.startPrank(owner);
        tamagotchi.createPet("TestPet");
        (,uint256 hungerBefore,,,, ) = tamagotchi.getPetStatus(owner);
        tamagotchi.feed();
        (,uint256 hungerAfter,,,, ) = tamagotchi.getPetStatus(owner);
        assertLt(hungerAfter, hungerBefore);
        vm.stopPrank();
    }

    function testPlay() public {
        vm.startPrank(owner);
        tamagotchi.createPet("TestPet");
        (,,uint256 happinessBefore,,, ) = tamagotchi.getPetStatus(owner);
        tamagotchi.play();
        (,,uint256 happinessAfter,,, ) = tamagotchi.getPetStatus(owner);
        assertGt(happinessAfter, happinessBefore);
        vm.stopPrank();
    }

    function testUpdateStatus() public {
        vm.startPrank(owner);
        tamagotchi.createPet("TestPet");
        vm.warp(block.timestamp + 2 days);
        tamagotchi.updateStatus();
        (,uint256 hunger, uint256 happiness, uint256 health,, uint256 age) = tamagotchi.getPetStatus(owner);
        assertGt(hunger, 50);
        assertLt(happiness, 50);
        assertLt(health, 100);
        assertEq(age, 2);
        vm.stopPrank();
    }

    function testFeedNonExistentPet() public {
        vm.prank(owner);
        vm.expectRevert("Pet not created");
        tamagotchi.feed();
    }

    function testPlayNonExistentPet() public {
        vm.prank(owner);
        vm.expectRevert("Pet not created");
        tamagotchi.play();
    }

    function testUpdateStatusNonExistentPet() public {
        vm.prank(owner);
        vm.expectRevert("Pet not created");
        tamagotchi.updateStatus();
    }

    function testGetPetStatusNonExistentPet() public {
        (string memory name, uint256 hunger, uint256 happiness, uint256 health, uint256 lastInteraction, uint256 age) = tamagotchi.getPetStatus(otherUser);
        assertEq(name, "");
        assertEq(hunger, 0);
        assertEq(happiness, 0);
        assertEq(health, 0);
        assertEq(lastInteraction, 0);
        assertEq(age, 0);
    }

    function testMultipleUsers() public {
        vm.prank(owner);
        tamagotchi.createPet("OwnerPet");
        
        vm.prank(otherUser);
        tamagotchi.createPet("OtherPet");

        (string memory ownerPetName,,,,, ) = tamagotchi.getPetStatus(owner);
        (string memory otherPetName,,,,, ) = tamagotchi.getPetStatus(otherUser);

        assertEq(ownerPetName, "OwnerPet");
        assertEq(otherPetName, "OtherPet");
    }
}
