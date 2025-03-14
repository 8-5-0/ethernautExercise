// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IDetectionBot{
    address public fortaAddress;
    address public vaultAddress;
    constructor (address a, address b) {
        fortaAddress = a;
        vaultAddress = b;
    }
    
    function handleTransaction(address user, bytes calldata msgData) public {
        address to;
        uint256 value;
        address from;
        (to, value, from) = abi.decode(msgData[4:], (address, uint256, address));
        if (from == vaultAddress){
            bytes memory data = abi.encodeWithSignature("raiseAlert(address)", user);
            fortaAddress.call(data);
        }

    }
}

// 不是很懂这题考察啥的，原合约不允许underlying token转移，只有CryptoVault.sweepToken(legacyTokenAddress)可以转移，检测传入的originSender!=CryptoVault.address即可