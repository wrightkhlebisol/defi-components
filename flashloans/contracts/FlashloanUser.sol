// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.3;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import './FlashloanProvider.sol';
import './FlashloanUser.sol';

contract FlashloanUser is IFlashloanUser {
    function startFlashLoan(address flashloan, uint amount, address token) external {
        FlashloanProvider(flashloan).executeFlashloan(
            address(this),
            amount,
            token,
            bytes('')
        );
    }

    function flashloanCallback(uint amount, address token, bytes memory data) external override {
        //  do some arbitrage, liuidation, etc...
        // Reimburse borrowed tokens
        IERC20(token).transfer(msg.sender, amount);
    }
}