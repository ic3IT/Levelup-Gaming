# Tamagotchi Game - Level 3

Hey there, blockchain developer! Ready to bring a digital pet to life on Ethereum? Let's dive into Level 3!

## Your Tamagotchi's Features

Your digital pet will:
- Have a name (that you give it)
- Get hungry over time
- Want to play and get bored
- Have health that changes based on hunger and happiness
- Age as time passes

## Your Coding Mission

1. Create the `Tamagotchi.sol` contract:

   - Define a `Pet` struct with:
     - `name` (string)
     - `hunger` (uint256)
     - `happiness` (uint256)
     - `health` (uint256)
     - `lastFed` (uint256)
     - `lastPlayed` (uint256)
     - `birthTime` (uint256)

   - Create a mapping: `mapping(address => Pet) public pets;`

   - Implement these functions:
     
     a) `createPet(string memory _name) external`:
        - Check if the caller already has a pet
        - Create a new Pet with default values
        - Set `lastFed` and `birthTime` to `block.timestamp`
     
     b) `feed() external`:
        - Check if the caller has a pet
        - Decrease hunger (min 0)
        - Update `lastFed`
     
     c) `play() external`:
        - Check if the caller has a pet
        - Increase happiness (max 100)
        - Increase hunger slightly
        - Update `lastPlayed`
     
     d) `updateStatus() private`:
        - Update health based on hunger and happiness
        - Calculate pet's age
     
     e) `getPetStatus() external view returns (uint256, uint256, uint256, uint256)`:
        - Return current hunger, happiness, health, and age

2. Add events for key actions (PetCreated, PetFed, PetPlayed)

3. Use `block.timestamp` for time-based calculations

4. Implement modifiers:
   - `onlyPetOwner` to ensure only the pet owner can interact with it

5. Gas Optimization:
   - Use `storage` for Pet struct when modifying multiple properties

## Deployment

When you're done, deploy to a testnet (Goerli or Sepolia) and show off your blockchain pet!

Remember, every interaction costs gas, so think about efficiency. Good luck, and may your Tamagotchi thrive in the blockchain world! 🐾
