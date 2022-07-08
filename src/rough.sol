// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Rough {
    function encodeInt(uint256 _i) external pure returns (bytes memory) {
        return abi.encode(_i);
    }

    function decodeInt(bytes memory _b) external pure returns (uint256 a) {
        (a) = abi.decode(_b, (uint256));
    }

    function encodeIntBool(uint256 _i, bool _j)
        external
        pure
        returns (bytes memory)
    {
        return abi.encode(_i, _j);
    }

    function decodeIntBool(bytes memory _a)
        external
        pure
        returns (uint256 i, bool j)
    {
        (i, j) = abi.decode(_a, (uint256, bool));
    }

    function get() external pure returns(bytes12, bytes32) {
	string memory str = '2';
	address addr = 0x63cDDcF737f3AD13492e8fa59C2D923C9cFAEf14;
	bytes12 temp = bytes12(keccak256(abi.encodePacked(str)));
	bytes32 result = bytes32(abi.encodePacked(addr, temp));
	return (temp, result);
   }
}
