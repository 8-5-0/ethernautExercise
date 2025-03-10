package main

import (
	"crypto/ecdsa"
	"encoding/binary"
	"encoding/hex"
	"fmt"
	"log"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/common/hexutil"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/rlp"
)

func CreateAddress(b common.Address, nonce uint64) common.Address {
	data, _ := rlp.EncodeToBytes([]interface{}{b, nonce})
	return common.BytesToAddress(crypto.Keccak256(data)[12:])
}
func find_owner() {
	found := false
	for !found {
		privateKey, err := crypto.GenerateKey()
		if err != nil {
			log.Fatal(err)
		}
		publicKey := privateKey.Public()
		publicKeyECDSA, _ := publicKey.(*ecdsa.PublicKey)
		owner_address := crypto.PubkeyToAddress(*publicKeyECDSA).Hex()
		// contract_address := CreateAddress(owner_address, 0).Hex()
		n, _ := hex.DecodeString(owner_address[len(owner_address)-8:])
		num := binary.BigEndian.Uint32(n)
		if num&0xffff == 0 {
			found = true
			privateKeyBytes := crypto.FromECDSA(privateKey)
			fmt.Printf("address is %s\nprivateKeyis %s\n", owner_address, hexutil.Encode(privateKeyBytes)[2:])
		}
	}
}

func main() {
	find_owner()
}
