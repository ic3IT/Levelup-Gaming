// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Implement necessary interfaces (if any)
// Implement any required libraries

contract Tamagotchi {
    // Define the Pet struct with necessary attributes
    struct Pet {
        string name;
        uint256 hunger;
        uint256 happiness;
        uint256 health;
        uint256 lastFed;
        uint256 creationTime;
    }

    // Create a mapping to associate addresses with Pets
    mapping(address => Pet) public pets;

    // Define events for key actions (PetCreated, PetFed, PetPlayed, StatusUpdated)
    event PetCreated(address owner, string name);
    event PetFed(address owner);
    event PetPlayed(address owner);
    event StatusUpdated(address owner, uint256 hunger, uint256 happiness, uint256 health, uint256 age);

    // Define the constructor (if needed)
    constructor() {
        // Initialize any necessary variables or state
    }

    // Create a function to create a new pet
    function createPet(string memory _name) external {
        require(pets[msg.sender].creationTime == 0, "You already have a pet");
        pets[msg.sender] = Pet(_name, 0, 50, 100, block.timestamp, block.timestamp);
        emit PetCreated(msg.sender, _name);
    }

    // Create a function to feed the pet
    function feed() external {
        Pet storage pet = pets[msg.sender];
        require(pet.creationTime != 0, "You don't have a pet");
        
        uint256 hungerIncrease = (block.timestamp - pet.lastFed) / 1 hours;
        pet.hunger = hungerIncrease > 100 ? 100 : pet.hunger + hungerIncrease;
        
        pet.hunger = 0;
        pet.lastFed = block.timestamp;
        
        emit PetFed(msg.sender);
        updateStatus();
    }

    // Create a function to play with the pet
    function play() external {
        Pet storage pet = pets[msg.sender];
        require(pet.creationTime != 0, "You don't have a pet");
        
        if (pet.happiness <= 90) pet.happiness += 10; else pet.happiness = 100;
        
        uint256 hungerIncrease = (block.timestamp - pet.lastFed) / 1 hours;
        pet.hunger = hungerIncrease > 100 ? 100 : pet.hunger + hungerIncrease;
        
        pet.lastFed = block.timestamp;
        
        emit PetPlayed(msg.sender);
        updateStatus();
    }

    // Create a private function to update pet's status
    function updateStatus() private {
        Pet storage pet = pets[msg.sender];
        
        if (pet.hunger > 80) {
            pet.health = pet.health > 5 ? pet.health - 5 : 0;
        } else if (pet.happiness < 20) {
            pet.health = pet.health > 5 ? pet.health - 5 : 0;
        } else {
            pet.health = pet.health < 95 ? pet.health + 5 : 100;
        }
        
        uint256 age = (block.timestamp - pet.creationTime) / 1 days;
        
        emit StatusUpdated(msg.sender, pet.hunger, pet.happiness, pet.health, age);
    }

    // Create a function to get pet's current status
    function getPetStatus() external view returns (uint256, uint256, uint256, uint256, uint256) {
        Pet storage pet = pets[msg.sender];
        require(pet.creationTime != 0, "You don't have a pet");
        
        uint256 currentHunger = min(100, pet.hunger + ((block.timestamp - pet.lastFed) / 1 hours));
        uint256 age = (block.timestamp - pet.creationTime) / 1 days;
        uint256 timeSinceLastFed = block.timestamp - pet.lastFed;
        
        return (currentHunger, pet.happiness, pet.health, age, timeSinceLastFed);
    }

    // Add a helper function for min calculation
    function min(uint256 a, uint256 b) private pure returns (uint256) {
        return a < b ? a : b;
    }
}
