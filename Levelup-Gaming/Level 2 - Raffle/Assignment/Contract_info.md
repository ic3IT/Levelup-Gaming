# Simple Raffle Contract Development Hints

When developing your Simple Raffle smart contract, consider the following aspects:

1. **State Variables**
   - `uint256 public ticketPrice`: Define the price of each raffle ticket
   - `address[] public participants`: Array to store participant addresses
   - `bool public raffleOpen`: To manage if the raffle is open or closed

2. **Key Functions**
   - `buyTicket() external payable`: Allow participants to purchase tickets
   - `drawWinner() external`: Function to select a winner and distribute the prize

3. **Events**
   - `TicketPurchased(address participant)`
   - `WinnerSelected(address winner, uint256 prize)`

4. **Winner Selection**
   - Use a simple method to select a winner from the participants array
   - You can use `block.timestamp` or `block.number` for basic randomness (note: not secure for real-world applications)

5. **Error Handling**
   - Use `require` statements to check if the raffle is open and if the correct ticket price is paid

6. **Basic Security**
   - Implement a simple check to ensure only the owner can draw the winner

Remember to keep the contract as simple as possible while still implementing the basic functionality of a raffle system.
