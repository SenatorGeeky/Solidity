//SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

contract TestArray{

    string[] public array = ["flowers", "rose", "tulips"];


    function update() public {

    array[1]= "hello world";

    }
      
    function update1(string memory _array) public {
        array[1]= _array;

    } 


    function getarray() public view returns(string[] memory) {

        return array;
    }
}
