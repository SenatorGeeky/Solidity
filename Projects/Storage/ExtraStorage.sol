// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract ExtraStroage is SimpleStorage{

    // 'is' inheritance from parent contract 
    //  to change some of the  functionality  of a parent contract we can use 'virtual' for parent contract and 'override'for child contract.  


    function store(uint256 _favouriteNumber) public override{

        favouriteNumber = _favouriteNumber+5;
    }


}
