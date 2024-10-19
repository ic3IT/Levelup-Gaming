# Tamagotchi Game - Level 3

Welcome to Level 3 of Levelup! In this level, you'll build the core functionalities of a decentralized Tamagotchi pet.

## Overview

Tamagotchi is a virtual pet simulation game. In this blockchain version, each pet is unique and owned by a player on the Ethereum blockchain.

## Features

- Create a new pet with a custom name
- Feed your pet to reduce hunger
- Play with your pet to increase happiness
- Automatic health updates based on hunger and happiness levels
- View your pet's current status (hunger, happiness, health)

## Smart Contract: Tamagotchi.sol

The `Tamagotchi.sol` contract contains the core game logic:

- `createPet(string memory _name)`: Create a new pet
- `feed()`: Feed your pet
- `play()`: Play with your pet
- `getPetStatus()`: Check your pet's current status
