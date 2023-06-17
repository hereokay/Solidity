// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


contract Token {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 amount
    ); 
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    ); 

    string public name = "My First Token";
    string public symbol = "MFT";
    uint public decimals = 18;
    uint public totalSupply = 0;

    mapping(address owner => uint amount) public balances;
    mapping(address owner => mapping(address spender => uint amount)) public allowances;

    function balanceOf(address owner) public view returns (uint balance) {
        return balances[owner];
    }

    function transfer(address to, uint amount) public returns (bool success) {
        address owner = msg.sender;
        require(balances[owner] >= amount);
        balances[owner] -= amount;
        balances[to] = balances[to] + amount;
        emit Transfer(owner, to, amount);
        return true;
    }

    function approve(
        address spender,
        uint amount
    ) public returns (bool success) {
        address owner = msg.sender;
        allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint amount) {
        return allowances[owner][spender];
    }

    function transferFrom(
        address from,
        address to,
        uint amount 
    ) public returns (bool success) {
        address spender = msg.sender;
        require(allowances[from][spender] >= amount);
        require(balances[from] >= amount);
        balances[from] -= amount;
        balances[to] += amount;
        allowances[from][spender] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }
}

