// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    constructor() ERC20("TokenA","A"){
        _mint(msg.sender, 50 * 10^18);
    }
}

// CPMM
contract Uniswap is ERC20 {
    // ETH <> A 
    address public tokenAddress;

    constructor(address _tokenAddress) ERC20("Uniswap LP","UNI-LP"){
        tokenAddress = _tokenAddress;
    }

    function addLiquidity() public payable {
        // LP 사용자로 부터 Ether, Token 을 받는다.
        uint etherAmount = msg.value;
        uint tokenAmount = etherAmount;
        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transfer(msg.sender, tokenAmount); // 유저의 토큰을 컨트랙트로 가져옴
        
        // LP 사용자에게 받은 만큼의 LP Token 을 민팅한다.
        _mint(msg.sender, etherAmount); 
    }

    function removeLiquidity(uint lpTokenAmount) public {

        // 1. LP 소각
        _burn(msg.sender, lpTokenAmount);

        uint etherAmount = lpTokenAmount;
        uint tokenAmount = lpTokenAmount;
        
        // 2. 해당 비분만큼 Ether, Token을 반환한다.

        payable(msg.sender).transfer(etherAmount);

        TokenA tokenContract = TokenA(tokenAddress);
        tokenContract.transfer(msg.sender, tokenAmount); // 유저의 토큰을 컨트랙트로 가져옴
    }

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

