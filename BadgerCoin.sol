// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract BEP20 is ERC20 {
    constructor() ERC20("BadgerCoin", "BC") {
        _mint(msg.sender, 1000000);
    }
}