// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "src/erc20.sol";

contract ContractTest is DSTest {
    ERC20 _erc20;

    function setUp() public {
        _erc20 = new ERC20("Test", "TST", 100000);
    }

    function testName() public view {
        require(
            keccak256(abi.encodePacked(_erc20.name())) == keccak256("Test")
        );
    }

    function testSymbol() public view {
        require(
            keccak256(abi.encodePacked(_erc20.symbol())) == keccak256("TST")
        );
    }

    function testTotalSupply() public view {
        require(_erc20.totalSuppply() == 100000 * (10**_erc20.decimals()));
    }
}
