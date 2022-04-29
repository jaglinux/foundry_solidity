// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "src/erc20.sol";
import "forge-std/Vm.sol";
import "forge-std/console2.sol";

contract ContractTest is DSTest {
    ERC20 _erc20;
    Vm private constant _Vm = Vm(HEVM_ADDRESS);
    uint256 private _id;
    uint256 private constant _users = 2;
    address payable[] private users;

    function setUp() public {
        _erc20 = new ERC20("Test", "TST", 100000);
        createUsers();
    }

    function createUsers() private {
        for (uint256 i; i < _users; i++) {
            users.push(createAddress());
            console2.log("user created");
            console2.logAddress(users[i]);
        }
    }

    function createAddress() private returns (address payable) {
        return payable(address(uint160(uint256(keccak256(abi.encode(_id++))))));
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

    function testTransfer() public {
        _erc20.transfer(users[0], 1000);
        console2.log(
            "user 0 token before transfer is ",
            _erc20.balanceOf(users[0])
        );
        _Vm.prank(users[0]);
        _erc20.transfer(users[1], 1000);
        console2.log(
            "user 0 token after transfer is ",
            _erc20.balanceOf(users[0])
        );
        console2.log(
            "user 1 token after transfer is ",
            _erc20.balanceOf(users[1])
        );
        require(_erc20.balanceOf(users[0]) == 0);
        require(_erc20.balanceOf(users[1]) == 1000);
    }

    function testDoubleTransfer() public {
        _erc20.transfer(users[0], 1000);
        console2.log(
            "user 0 token before transfer is ",
            _erc20.balanceOf(users[0])
        );
        _Vm.prank(users[0]);
        _erc20.transfer(users[1], 1000);
        _Vm.prank(users[1]);
        _erc20.transfer(users[0], 1000);
        console2.log(
            "user 0 token after double transfer is ",
            _erc20.balanceOf(users[0])
        );
        console2.log(
            "user 1 token after double transfer is ",
            _erc20.balanceOf(users[1])
        );
        require(_erc20.balanceOf(users[0]) == 1000);
        require(_erc20.balanceOf(users[1]) == 0);
    }

    function testMint() public {
        uint256 supply = _erc20.totalSuppply();
        _erc20.mint(users[0], 1000);
        console2.log("Total Supply is ", _erc20.totalSuppply());
        require(supply + 1000 == _erc20.totalSuppply());
        require(_erc20.balanceOf(users[0]) == 1000);
    }

    function testBurn() public {
        uint256 supply = _erc20.totalSuppply();
        _erc20.transfer(users[0], 1000);
        console2.log(
            "user 0 token before balance is ",
            _erc20.balanceOf(users[0])
        );
        _Vm.prank(users[0]);
        _erc20.burn(1000);
        console2.log(
            "user 0 token after balance is ",
            _erc20.balanceOf(users[0])
        );
        console2.log("Total Supply is ", _erc20.totalSuppply());
        require(_erc20.totalSuppply() == supply - 1000);
    }
}
