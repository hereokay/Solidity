// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Product {
    uint public number;
    constructor(uint _number){
        number = _number;
    }
}

contract Factory {

    mapping(uint => address) numberToProduct; // 같은 프로덕트가 생성되지 않도록
    mapping(address => uint) productToNumber; // 프로덕트의 숫자를 알기
    
    function createProduct(uint number) public returns(address) {
        Product created = new Product(number);

        numberToProduct[number] = address(created);
        productToNumber[address(created)] = number;

        return address(created);
    }
}
