// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    constructor() ERC20("TokenA","A"){}
}

contract Uniswap {
    // ETH <> A 
    address tokenAddress;


    function etherToTokenSwap() public payable {
        uint etherAmount = msg.value;
        uint tokenAmount = etherAmount; // A토큰을 주는 행위
        
        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transfer(msg.sender, tokenAmount);
    }

    function tokenToEtherSwap(uint tokenAmount) public {

        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transferFrom(msg.sender,address(this),tokenAmount);
        
        uint etherAmount = tokenAmount;
        payable(msg.sender).transfer(etherAmount);

    }


}