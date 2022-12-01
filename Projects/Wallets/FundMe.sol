// SPDX-License-Identifier: MIT


// Get Funds from users
// Withdraw funds
// Set a Minimum funding in USD


pragma solidity 0.8.8; 

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUSD = 50 * 1e18;
    address[] public funders;
    mapping (address=> uint256) public adressToAmountFunded; // mapping of how much money is being send by individual address 

    function fund() public payable{

        //  want to be able to set a minimum fund amount in USD
        //  How do we send ETH to this contract?

        require(getConversionRate(msg.value)>= 1e18, "Didn't send enough Ether"); // 1e18 == 1 *10 ** 18 = 1000000000000000000
         
         // revertings: undo any action before, and sends remaining gas back 
        
        // Blockchain Oracle: Any Device that interacts with the off-chain world to provide external data-
        // or compution to smart contracts.

        //msg.sender: sender of the message
        //msg.value : number of wei sent with the message
        


        funders.push(msg.sender);
        adressToAmountFunded[msg.sender] = msg.value;

    }

    function getPrice() public view returns(uint256) {
        // ABI
        // Adress 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        // Chainlink docs for price Feed: https://docs.chain.link/data-feeds/price-feeds

        AggregatorV3Interface priceFeed= AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 price,,,)=priceFeed.latestRoundData();

        //msg.sender returns 18 decimals while price returns 8 so to make it same decimals 
        //Eth in terms of USD: 1200.00000000
        //msg.value is in uint256 but price is in int256, coversion can be done by type-casting:- uint256(price*1e10);
         return uint256(price * 1e10); // 1**10 == 10000000000


    }


    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethprice = getPrice();
        // Eth price = 1200 with additonal 18 zeros
        // example 1Eth sending to contract: 1 with additonal 18zeros 
        uint256 ethAmountInUsd = (ethprice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    
}
