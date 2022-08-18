//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./BaseERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract CoinToss is ReentrancyGuard {
    BaseERC20 public betCoin;
    using SafeMath for uint256;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    event BetStatus(bool status);

    constructor(BaseERC20 _betCoinAddr) {
        betCoin = _betCoinAddr;
    }

    /**
     * @dev A method for Betting
     * @param _betAmount : Bet Amount
     */
    function startBet(uint256 _betAmount) public {
        require(_betAmount > 0, "Bet Amount should be much than 0");
        if (_betAmount > betCoin.balanceOf(address(this))) {
            betCoin.transferFrom(msg.sender, address(this), _betAmount);
            betCoin.transfer(msg.sender, _betAmount);
        } else {
            betCoin.transferFrom(msg.sender, address(this), _betAmount);
            uint256 blockValue = uint256(blockhash(block.number.sub(1)));
            if (lastHash == blockValue) {
                revert();
            }
            lastHash = blockValue;
            uint256 coinFlip = blockValue.div(FACTOR);
            bool side = coinFlip == 1 ? true : false;
            if (side == true) {
                // If contract win
                betCoin.transfer(msg.sender, 0);
                emit BetStatus(true);
            } else {
                // If contract lose
                betCoin.transfer(msg.sender, 2 * _betAmount);
                emit BetStatus(false);
            }
        }
    }

    /**
     * @dev A method for getting the balance of contract
     */
    function getBalance() external view returns (uint256) {
        return betCoin.balanceOf(address(this));
    }
}
