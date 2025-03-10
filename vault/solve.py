from web3 import Web3, eth

provider_url = "https://sepolia-rollup.arbitrum.io/rpc"
w3 = Web3.HTTPProvider(provider_url)
w3.eth.get_storage_at(0x7DbDFfaC453759f362B01205977691C772533DC1,0)
w3.eth.get_storage_at(0x7DbDFfaC453759f362B01205977691C772533DC1,1)#password