// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PuppyCoinGame is ERC20 {
    uint256 public currentDividend;        
    uint256 dividendRate = 12;  // dividend rate of 12%      
    address payable[] public investors;   
    address role;                      
    uint256 public numberInvestors = 0;  
    event payDividends(uint256 indexed);


    constructor() ERC20("PuppyCoin", "PUC") {
        dividendRate = 12;
    }

    modifier onlyAdmin(){
        if (tx.origin==role){
            _;
        }
    }

    function addInvestor(address payable _investor) public payable {
        if (msg.value == 2) {
            investors.push(_investor);
            currentDividend ++;
        }
        if (numberInvestors > 200) {
            makePayout(100);
            emit payDividends(200);
        }
    }



    function makePayout(uint256 _payees) public onlyAdmin {
        if (address(this).balance == 100) {
            uint256 amountToPay = numberInvestors/ 100;
            payOutDividends(amountToPay);
        }
    }

    function payOutDividends(uint256 _amount) public {
        uint256 currentDividend = _amount / dividendRate;
        for (uint256 i = 0; i <= investors.length; i++) {
            investors[i].transfer(currentDividend);
        }
    }
}