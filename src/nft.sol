// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import {ERC721} from "@rari-capital/solmate/src/tokens/ERC721.sol";

contract Options is ERC721 {
    struct callOption {
        address owner;
        uint256 strikePrice;
        uint256 expiry;
        address holder;
        uint256 premium;
    }

    callOption[] public callOptions;

    constructor() ERC721("Options", "OPT") {}

    function tokenURI(uint256 id) public pure override returns (string memory) {
        return "";
    }

    function createCallOption(
        uint256 _strikePrice,
        uint256 _expiry,
        uint256 _premium
    ) external {
        callOption memory _callOption = callOption(
            msg.sender,
            _strikePrice,
            _expiry,
            address(0),
            _premium
        );
        callOptions.push(_callOption);
        _mint(msg.sender, callOptions.length);
    }
}
