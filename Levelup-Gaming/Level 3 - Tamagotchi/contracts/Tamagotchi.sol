// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Tamagotchi {
    struct Pet {
        string name;
        uint256 hunger;
        uint256 happiness;
        uint256 health;
        uint256 lastInteraction;
        uint256 age;
    }

    mapping(address => Pet) public pets;

    event PetCreated(address owner, string name);
    event PetFed(address owner);
    event PetPlayed(address owner);
    event StatusUpdated(address owner, uint256 hunger, uint256 happiness, uint256 health, uint256 age);

    modifier onlyPetOwner() {
        require(pets[msg.sender].lastInteraction != 0, "You don't have a pet");
        _;
    }

    function createPet(string memory _name) public {
        require(pets[msg.sender].lastInteraction == 0, "You already have a pet");
        pets[msg.sender] = Pet(_name, 50, 50, 100, block.timestamp, 0);
        emit PetCreated(msg.sender, _name);
    }

    function feed() public onlyPetOwner {
        Pet storage pet = pets[msg.sender];
        pet.hunger = pet.hunger > 10 ? pet.hunger - 10 : 0;
        pet.lastInteraction = block.timestamp;
        emit PetFed(msg.sender);
        updateStatus();
    }

    function play() public onlyPetOwner {
        Pet storage pet = pets[msg.sender];
        pet.happiness += 10;
        if (pet.happiness > 100) pet.happiness = 100;
        pet.hunger += 5;
        if (pet.hunger > 100) pet.hunger = 100;
        pet.lastInteraction = block.timestamp;
        emit PetPlayed(msg.sender);
        updateStatus();
    }

    function updateStatus() private {
        Pet storage pet = pets[msg.sender];
        if (pet.hunger > 80) {
            pet.health -= 5;
        } else if (pet.happiness < 20) {
            pet.health -= 5;
        } else {
            pet.health += 1;
        }
        if (pet.health > 100) pet.health = 100;
        if (pet.health < 0) pet.health = 0;

        // Age the pet
        pet.age = (block.timestamp - pet.lastInteraction) / 1 days;

        emit StatusUpdated(msg.sender, pet.hunger, pet.happiness, pet.health, pet.age);
    }

    function getPetStatus() public view onlyPetOwner returns (uint256, uint256, uint256, uint256) {
        Pet storage pet = pets[msg.sender];
        return (pet.hunger, pet.happiness, pet.health, pet.age);
    }
}
