// import "@openzeppelin/contracts/access/Ownable.sol";

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract CoinFlip {
    uint256 public constant MINIMUM_BET = 0.01 ether;

    event CoinFlipped(address player, bool betOnHeads, bool result, uint256 amountWon);

    function flipCoin(bool _betOnHeads) external payable {
        require(msg.value >= MINIMUM_BET, "Bet amount too low");
        require(address(this).balance >= msg.value * 2, "Insufficient contract balance");

        bool result = random() % 2 == 0;

        bool playerWon = (result == _betOnHeads);

        uint256 payout = playerWon ? msg.value * 2 : 0;

        emit CoinFlipped(msg.sender, _betOnHeads, result, payout);

        if (playerWon) {
            (bool success, ) = payable(msg.sender).call{value: payout}("");
            require(success, "Transfer failed");
        }
    }

    function random() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender)));
    }

    receive() external payable {}
}
