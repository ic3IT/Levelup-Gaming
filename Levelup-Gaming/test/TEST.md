# Testing Guide for Level Up Gaming Contracts

This guide explains how to run tests for the smart contracts in the Level Up Gaming project using Foundry.

## Prerequisites

1. Ensure you have Foundry installed. If not, follow the installation guide at [https://book.getfoundry.sh/getting-started/installation](https://book.getfoundry.sh/getting-started/installation).

2. Make sure you're in the project directory (`Levelup-Gaming`).

## Running Tests

To run all tests for all contracts:

--forge -vvv


## Testing Individual Contracts

To test a specific contract, use the `--match-contract` flag:

1. For CoinFlip:
   ```bash
   forge test --match-contract CoinFlipTest
   ```

2. For SimpleRaffle:
   ```bash
   forge test --match-contract SimpleRaffleTest
   ```

3. For Tamagotchi:
   ```bash
   forge test --match-contract TamagotchiTest
   ```

## Understanding Test Files

Each contract in the `src` directory has a corresponding test file in the `test` directory:

- `src/CoinFlip.sol` is tested by `test/CoinFlip.t.sol`
- `src/SimpleRaffle.sol` is tested by `test/SimpleRaffle.t.sol`
- `src/Tamagotchi.sol` is tested by `test/Tamagotchi.t.sol`

