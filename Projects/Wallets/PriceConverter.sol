// SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

     function getPrice() internal view returns(uint256) {
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


    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethprice = getPrice();
        // Eth price = 1200 with additonal 18 zeros
        // example 1Eth sending to contract: 1 with additonal 18zeros 
        uint256 ethAmountInUsd = (ethprice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    
}
