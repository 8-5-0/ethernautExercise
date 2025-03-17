pragma solidity >0.7.0;

contract Hack{
    bytes public test;
    bytes32 public s2;
    address public a;
    constructor(){}
    function solve() public {
        bytes32 r = hex"1932cb842d3e27f54f79f7be0289437381ba2410fdefbae36850bee9c41e3b91";
        bytes32 s = hex"78489c64a0db16c40ef986beccc8f069ad5041e5b992d76fe76bba057d9abff2";
        uint8 v = 0x1b;
        bytes32 msgHash = hex"f413212ad6f041d7bf56f97eb34b619bf39a937e1c2647ba2d306351c6d34aae";
        a = ecrecover(msgHash, v, r, s);

        s2 = bytes32(uint256(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141) - uint256(s));
        uint8 v2=0x1c;
        address b = ecrecover(msgHash, v2, r, s2);

        assert(a==b);
        // test = abi.encode([uint256(r), uint256(s), uint256(v)]);

    }
}

/**
 * 密码学问题,ecrecover签名可以重放,如上所示
 */