pragma solidity ^0.7.3;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import './FlashloanProvider.sol';
import './FlashloanUser.sol';

contract FlashloanUser is IFlashloanUser {
    function startFlashLoan(address flashloan, uint amount, address token) external {
        FlashloanProvider(flashloan).executeFlashloan()
    }
}