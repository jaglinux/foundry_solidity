// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "src/rough.sol";
import "forge-std/Vm.sol";
import "forge-std/console2.sol";

contract RoughContract is DSTest {
    Rough _rough;

    function setUp() public {
        _rough = new Rough();
    }

    function testInt() public view {
        bytes memory a = _rough.encodeInt(8);
        console2.log("int bytes ");
        console2.logBytes(a);
        uint256 i = _rough.decodeInt(a);
        require(i == 8);
    }

    function testIntBool() public view {
        bytes memory a = _rough.encodeIntBool(8, true);
        console2.log("int bool");
        console2.logBytes(a);
        uint256 i;
        bool j;
        (i, j) = _rough.decodeIntBool(a);
        require(i == 8);
        require(j == true);
    }
}
