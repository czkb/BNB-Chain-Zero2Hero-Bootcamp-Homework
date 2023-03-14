// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;


contract BootcampContract {

    uint256 number;
    address public deployer;

    constructor() {
        deployer = msg.sender;
    }

    function getAddress() external view returns(address){
        if(msg.sender == deployer){
            return address(0x000000000000000000000000000000000000dEaD);
        } else {
            return deployer;
        }
    }

    function store(uint256 num) public {
        number = num;
    }


    function retrieve() public view returns (uint256){
        return number;
    }
}