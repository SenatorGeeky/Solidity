// SPDX-License-Identifier: MIT


// Get Funds from users
// Withdraw funds
// Set a Minimum funding in USD


pragma solidity 0.8.8; 
import "./PriceConverter.sol";

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;
    
    // 21,415 gas - constant 
    // 23,515 gas - non-constant 

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    mapping (address=> uint256) public adressToAmountFunded; // mapping of how much money is being send by individual address 
     
     address public immutable i_owner;
     // 21,508 gas - immutable
     // 23,644 gas - non-immutable
    
     constructor() {
       i_owner = msg.sender;
      }


    function fund() public payable{

        //  want to be able to set a minimum fund amount in USD
        //  How do we send ETH to this contract?

        require(msg.value.getConversionRate()>= 1e18, "Didn't send enough Ether"); // 1e18 == 1 *10 ** 18 = 1000000000000000000
         
         // revertings: undo any action before, and sends remaining gas back 
        
        // Blockchain Oracle: Any Device that interacts with the off-chain world to provide external data-
        // or compution to smart contracts.

        //msg.sender: sender of the message
        //msg.value : number of wei sent with the message



        funders.push(msg.sender);
        adressToAmountFunded[msg.sender] = msg.value;

    }

    function withdraw() public onlyOwner {
        
        //for loop

         //for( starting index, ending index, step amount )
         //        0                10                2    (0 TO 10 WITH 2 EACH TIME)
            for(uint256 funderIndex = 0; funderIndex< funders.length; funderIndex= funderIndex +1) {
                 address funder = funders[funderIndex];
                 adressToAmountFunded[funder] = 0;
            }

            // reset array 

            funders = new address[](0); //brand new address with zero elements
         // withdraw the funds 

         /* transfer:
          msg.sender is of type address
          payable(msg.sender) is of type payable address

         code: payable(msg.sender.transfer(address(this).balance);

         capped at 2300 gas, if more gas used throws error */

         /* send
          
         code: bool sendSuccess= payable(msg.sender).send(address(this).balance);
               require(sendSuccess, "Send Failed");


         capped at 2300 gas, if more gas used returns a bool */

         /*call

         code: (bool callSuccess, bytes memory dataReturned)= payable(msg.sender).call{value: address(this).balance("");
                require(callSuccess, "call failed");

         doesn't have capped gas or set gas, return bool */        


    }

    modifier onlyOwner {
        //require(msg.sender == i_owner, "sender is not owner");
        if(msg.sender != i_owner)  { revert NotOwner(); }
        _;
    }
    // what happens if someone sends eth to this contract without calling the fund 

    // receive () 
    // fallback ()

    receive() external payable {
        fund();

    }

    fallback() external payable {
        fund ();
    } 

}
