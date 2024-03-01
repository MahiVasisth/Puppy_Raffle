// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;
import {Test, console} from "forge-std/Test.sol";
import {PuppyRaffle} from "../src/PuppyRaffle.sol";
import {PuppyRaffleReentrancy} from "../src/PuppyRaffleRentrancy.sol";
contract PuppyRaffleTest is Test {
    PuppyRaffle puppyRaffle;
    PuppyRaffleReentrancy attack;
    uint256 entranceFee = 1e18;
    address feeAddress = address(99);
    uint256 duration = 1 days;
    address playerOne = address(1);
    address playerTwo = address(2);
    address playerThree = address(3);
    address playerFour = address(4);
    
    function setUp() public {
        puppyRaffle = new PuppyRaffle(
            entranceFee,
            feeAddress,
            duration
        );
        attack = new PuppyRaffleReentrancy(puppyRaffle);
    }


    //////////////////////
    /// EnterRaffle    ///
    /////////////////////
    function testreentrancy() public {
        address[] memory players = new address[](4);
        players[0] = playerOne;
        players[1] = playerTwo;
        players[2] = playerThree;
        players[3] = playerFour;
        puppyRaffle.enterRaffle{value: entranceFee * 4}(players);
        console.log("balance of raffle before reentrancy attack",address(puppyRaffle).balance);
        console.log("balance of player before reentrancy attack", address(attack).balance);
        attack.entrypoint{value : entranceFee}();
        console.log("balance of raffle after reentrancy attack",address(puppyRaffle).balance);
        console.log("balance of player after reentrancy attack", address(attack).balance);
        assertEq(address(puppyRaffle).balance , 0);
    }
}