// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract Hack{
    constructor() public {}

    function sendTo(address add) public {
        bytes memory data = abi.encodeWithSignature("enter(bytes8)",0x00000000deadbeef);
        add.call(data);
    }
}