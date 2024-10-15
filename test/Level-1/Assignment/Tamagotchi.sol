// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Tamagotchi {
    // Define the Pet struct with necessary attributes
    struct Pet {
        string name;
        uint256 hunger;
        uint256 happiness;
        uint256 health;
        uint256 lastFed;
        uint256 creationTime;
        // TODO: Add any additional attributes you think are necessary
    }

    // TODO: Create a mapping to associate addresses with Pets

    // TODO: Define events for key actions (PetCreated, PetFed, PetPlayed, StatusUpdated)

    // TODO: Implement a modifier to check if the caller has a pet

    // Function to create a new pet
    function createPet(string memory _name) public {
        // TODO: Check if the caller already has a pet (use require)
        // TODO: Initialize a new Pet with default values (hunger: 0, happiness: 50, health: 100, lastFed: block.timestamp, creationTime: block.timestamp)
        // TODO: Emit PetCreated event
    }

    // Function to feed the pet
    function feed() public {
        // TODO: Implement onlyPetOwner modifier
        // TODO: Calculate hunger increase since last feeding (use block.timestamp - pet.lastFed)
        // TODO: Reset hunger to 0 after feeding
        // TODO: Update lastFed to current timestamp
        // TODO: Emit PetFed event
        // TODO: Call updateStatus()
    }

    // Function to play with the pet
    function play() public {
        // TODO: Implement onlyPetOwner modifier
        // TODO: Increase happiness by 10 (max 100)
        // TODO: Increase hunger based on time since last fed (similar to feed function)
        // TODO: Update lastFed to current timestamp
        // TODO: Emit PetPlayed event
        // TODO: Call updateStatus()
    }

    // Private function to update pet's status
    function updateStatus() private {
        // TODO: Update health based on hunger and happiness
        // If hunger > 80, decrease health by 5
        // If happiness < 20, decrease health by 5
        // Otherwise, increase health by 1 (max 100)
        
        // TODO: Calculate pet's age based on creationTime
        // Age should increase by 1 for each day since creation

        // TODO: Emit StatusUpdated event with current stats
    }

    // Function to get pet's current status
    function getPetStatus() public view returns (uint256, uint256, uint256, uint256, uint256) {
        // TODO: Implement onlyPetOwner modifier
        // TODO: Calculate current hunger based on time since last fed
        // Use: uint256 currentHunger = min(100, pet.hunger + ((block.timestamp - pet.lastFed) / 1 hours));
        // TODO: Return pet's current hunger, happiness, health, age, and time since last fed
    }
}
