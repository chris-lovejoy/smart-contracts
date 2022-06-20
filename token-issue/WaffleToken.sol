pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WaffleToken is IERC20 {
    string public constant name = "WaffleToken";
    string public constant symbol = "WFL";
    uint8 public constant decimals = 18;

    uint256 _totalSupply;

    mapping(address => uint) balances;
    
    mapping(address => mapping(address => uint)) allowances;

    event TransferEmit(address fromAccount, address toAccount, uint256 amountTransferred);

    constructor(uint _initialBalance) {
        _totalSupply = _initialBalance;
        balances[msg.sender] = _totalSupply;
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;

        emit TransferEmit(msg.sender, recipient, amount);
        return true;
    }
    
    

    function allowance(address owner, address spender) external override view returns (uint256) {
        return allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        allowances[msg.sender][spender] = amount;
        // TODO: add emit Approval
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        require(allowances[sender][msg.sender] >= amount, "Insufficient balance");
        balances[sender] -= amount;
        balances[recipient] += amount;
        allowances[sender][msg.sender] -= amount;

        // TODO add emit transfer
        return true;
    }

}
