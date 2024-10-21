// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

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

    function createPet(string memory _name) external {
        require(bytes(pets[msg.sender].name).length == 0, "Pet already exists");
        pets[msg.sender] = Pet({
            name: _name,
            hunger: 50,
            happiness: 50,
            health: 100,
            lastInteraction: block.timestamp,
            age: 0
        });
    }

    function feed() external {
        Pet storage pet = pets[msg.sender];
        require(bytes(pet.name).length > 0, "Pet not created");
        pet.hunger = pet.hunger > 10 ? pet.hunger - 10 : 0;
        pet.lastInteraction = block.timestamp;
    }

    function play() external {
        Pet storage pet = pets[msg.sender];
        require(bytes(pet.name).length > 0, "Pet not created");
        pet.happiness += 10;
        pet.lastInteraction = block.timestamp;
    }

    function updateStatus() external {
        Pet storage pet = pets[msg.sender];
        require(bytes(pet.name).length > 0, "Pet not created");
        uint256 timePassed = (block.timestamp - pet.lastInteraction) / 1 days;
        pet.hunger += timePassed * 10;
        pet.happiness -= timePassed * 5;
        pet.health = pet.health > timePassed * 5 ? pet.health - timePassed * 5 : 0;
        pet.age += timePassed;
        pet.lastInteraction = block.timestamp;
    }

    function getPetStatus(address _owner) external view returns (string memory, uint256, uint256, uint256, uint256, uint256) {
        Pet storage pet = pets[_owner];
        return (pet.name, pet.hunger, pet.happiness, pet.health, pet.lastInteraction, pet.age);
    }
}
