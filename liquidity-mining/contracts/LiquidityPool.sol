pragma solidity ^0.7.3;

import './UnderlyingToken.sol';
import './LpToken.sol';
import './GovernanceToken.sol';

contract LiquidityPool is LpToken{
    mapping(address => uint) public checkPoints;
    Underlying public underlyingToken;
    GovernanceToken public governanceToken;

    uint constant public REWARD_PER_BLOCK = 1;

    constructor(address _underlyingToken, address _governanceToken){
        underlyingToken = UnderlyingToken(_underlyingToken);
        governanceToken = GovernanceToken(_governanceToken);
    }

    function deposit(uint amount) external {
        if(checkPoints[msg.sender] == 0){
            checkpoints[msg.sender] = block.number;
        }
        _distributeRewards(msg.sender);
        underlyingToken.transferFrom(msg.sender, address(this), amount);
        _mint(msg.sender, amount);
    }

    function withdraw(uint amount) external {
        require(balanceOf(msg.sender) >= amount, 'not enough LP Tokens');
        _distributeRewards(msg.sender);
        underlyingToken.transfer(msg.sender, amount);
        _burn(msg.sender, amount);

    }

    function _distributeRewards(address beneficiary) internal {
        uint checkpoint = checkPoints[beneficiary];
        if(block.number - checkpoint > 0){
            // Multiply by exchange rate
            uint distributionAmount = balanceOf(beneficiary) 
                * (block.number - checkpoint) 
                * REWARD_PER_BLOCK;
            governanceToken.mint(beneficiary, distributionAmount);
            checkpoints[beneficiary] = block.number;
        }
    }

}