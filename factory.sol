// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Product {
    uint public number;
    constructor(uint _number){
        number = _number;
    }
}
    
contract Factory {
    
    function createProduct(uint number) public returns(address) {
        Product created = new Product(number);
        return address(created);
    }

}
