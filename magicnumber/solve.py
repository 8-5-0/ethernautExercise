from web3 import Web3
from eth_account.account import Account, SignedTransaction
import time

provider_url = "https://sepolia-rollup.arbitrum.io/rpc"
w3 = Web3(Web3.HTTPProvider(provider_url))

main_private_key = "0x4c93e99df964f043149b68ae9d6c994e684f0cacec41becbd5da0a082629684c"
main_account = w3.eth.account.from_key(main_private_key)

"""
---initcode---
push len(runtimecode) 60 0a
push offset()         60 0c
push dstoffset        60 00
CODECOPY              39

push len(runtimecode) 60 0a
push 0                60 00
return                f3


---runtimecode---
push 2a(value)        60 2a
push 00(offset)       60 00
mstore                52
push 20(length)       60 20
push 02(offset)       60 00
return                f3
"""


bytecode = "600a600c600039600a6000f3"+"602a60005260206000f3"
abi = """[
    {
        "inputs": [],
        "name": "whatIsTheMeaningOfLife",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "function"
    }
]"""

contract_instance = w3.eth.contract(abi=abi, bytecode=bytecode)
tx = contract_instance.constructor().build_transaction({
        'nonce': w3.eth.get_transaction_count(main_account.address),
        'value': 0,
        'gas': 1000000,
        'gasPrice': w3.eth.gas_price})
sign_tx: SignedTransaction = Account.sign_transaction(tx, main_private_key)
tx_hash = w3.eth.send_raw_transaction(sign_tx.raw_transaction)
