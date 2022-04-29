// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ERC20 {
    event log(string);
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;
    string public name;
    string public symbol;
    uint256 public constant decimals = 18;
    uint256 public totalSuppply;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _val
    ) {
        name = _name;
        symbol = _symbol;
        _mint(msg.sender, _val * (10**decimals));
    }

    modifier notEnoughBalance(address _user, uint256 _val) {
        require(balances[_user] >= _val, "not enough balance");
        _;
    }

    function balanceOf(address _user) external view returns (uint256) {
        return balances[_user];
    }

    function _mint(address _dest, uint256 _val) private {
        balances[_dest] += _val;
        totalSuppply += _val;
    }

    function _burn(address _dest, uint256 _val)
        private
        notEnoughBalance(_dest, _val)
    {
        balances[_dest] -= _val;
        totalSuppply -= _val;
    }

    function transfer(address _dest, uint256 _val)
        external
        notEnoughBalance(msg.sender, _val)
    {
        balances[msg.sender] -= _val;
        balances[_dest] += _val;
    }

    function approve(address _spender, uint256 _val)
        external
        notEnoughBalance(msg.sender, _val)
    {
        allowances[msg.sender][_spender] += _val;
    }

    function transferFrom(
        address _owner,
        address _dest,
        uint256 _val
    ) external notEnoughBalance(_owner, _val) {
        require(
            allowances[_owner][msg.sender] >= _val,
            "not enough allowances"
        );
        balances[_owner] -= _val;
        balances[_dest] += _val;
        allowances[_owner][msg.sender] -= _val;
    }
}
