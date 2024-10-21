# Simple Raffle Smart Contract - Level 2

Hey there, ready to build a raffle on the blockchain? Let's dive in!

## What We're Aiming For

1. Create a basic Raffle contract (nothing too fancy)
2. Figure out how to handle multiple players buying tickets
3. Set up a fair way to pick a winner (no cheating allowed!)
4. Manage the raffle's lifecycle and dish out the prize

## Game Plan

1. Set up your contract:
   - Use the latest Solidity version
   - Grab some OpenZeppelin contracts to make life easier

2. Core raffle stuff:
   - Set a ticket price
   - Keep track of who's playing
   - Create some events to log important stuff
   - Build the main `buyTicket` function
   - Add ways to start and end the raffle

3. Raffle logic:
   - Make sure people can only buy tickets when the raffle's open
   - Keep a list of everyone who bought a ticket
   - Create a function to pick a winner (randomly, of course)

4. Handling the prize:
   - Set up a way to send the prize to the winner
   - Make sure only you (the owner) can pick the winner and send the prize

5. Keep it secure:
   - Use OpenZeppelin's Ownable to control who can do what
   - Throw in some ReentrancyGuard to prevent sneaky attacks

6. Events and error handling:
   - Emit events when tickets are bought, raffle state changes, and a winner is picked
   - Use `require` statements to catch any weird situations

## Deployment

When you're done, deploy your contract to a testnet like Goerli or Sepolia to see it in action.

Remember, the goal is to keep things fair and secure. Good luck, and have fun building your raffle!
