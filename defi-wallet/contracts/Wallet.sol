// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.3;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Compound.sol";


contract Wallet is Compound {

    address public admin;

    constructor (
        address _comptroller,
        address _cEthAddress
    ) Compound(_comptroller, _cEthAddress){
        admin = msg.sender;
    }

    function deposit(
        address cTokenAddress,
        uint underlyingAmount
    ) external {
        address underlyingAddress = getUnderlyinAddress(cTokenAddress);
        IERC20(underlyingAddress).transferFrom(msg.sender, address(this), underlyingAmount);
        supply(cTokenAddress, underlyingAmount);
    }
}
