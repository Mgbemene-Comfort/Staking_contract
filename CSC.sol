// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "contracts/base/Staking20Base.sol";

contract Staking {
    event Staked (address indexed user, uint256 amount);
    event withdraw (address owner, address stacker, uint256 amount );
    
    address userAddress;
    address public owner;

    mapping(address => uint256) stakes;

    function stake (uint _amount) external {
        require(msg.sender != address(0), "address zero detected");
        require(_amount > 0, "can't stake zero value");
        require(IERC20(userAddress).balanceOf(msg.sender) >= _amount, "insufficientfunds");
        stakes [msg.sender] +=_amount; 

        emit Staked (msg.sender, _amount);
    }
    function getUserStakes(address _userAddress) external view returns (uint256) {
        return stakes[_userAddress];
    }
    function withdraw () external {
        require(msg.sender == owner, "you are not the owner");
        uint256 stakeBalance = IERC20(userAddress).balanceOf(address(this));

        emit withdraw(owner, stakeBalance);
    }
    function showStakeBalance() external view returns (uint) {
        return IERC20 (userAddress).balanceOf(address(this));
    }
}