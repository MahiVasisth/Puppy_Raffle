// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {Test, console} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {ReentrancyAttack} from "../src/ReentrancyAttack.sol";
import {ReentrancyExercise} from "../src/ReentrancyExercise.sol";
contract ReentrancyTest is Test {
  ReentrancyAttack public attacker;
  ReentrancyExercise public vault;
  address public victim = makeAddr("victim");
  address public hacker = makeAddr("hacker");
  uint256 amountToDeposited = 5 ether;
  uint256 attackerCapital = 1 ether;

  function setUp() public {
    vault = new ReentrancyExercise();
    attacker = new ReentrancyAttack(address(vault));
    vm.deal(victim , amountToDeposited);
    vm.deal(hacker , attackerCapital);
}
   function testforReentrancy() public {
    vm.prank(victim);
    vault.deposit{value:amountToDeposited}();
    console.log(address(vault).balance);
    assertEq(address(victim).balance , 0);
    vm.prank(hacker);
    attacker.attack{value:attackerCapital}();
    assertEq(address(vault).balance , 0);
  
}

}