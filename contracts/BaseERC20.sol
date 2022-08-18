//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BaseERC20 is ERC20, Ownable {
    uint256 public tokenTotalSupply = 1000000 * 10**18;

    constructor() ERC20("BetCoin", "BetCoin") {
        _mint(msg.sender, tokenTotalSupply);
    }
}
