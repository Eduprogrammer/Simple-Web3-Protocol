// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./MyToken.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Staking is ReentrancyGuard {
    MyToken public immutable token;

    mapping(address => uint) public balance;

    constructor(address _token) {
        token = MyToken(_token);
    }

    function stake(uint amount) public {
        require(amount > 0, "Valor invalido");

        token.transferFrom(msg.sender, address(this), amount);
        balance[msg.sender] += amount;
    }

    function withdraw() public nonReentrant {
        uint amount = balance[msg.sender];
        require(amount > 0, "Nada para sacar");

        balance[msg.sender] = 0;

        // recompensa simples (10%)
        uint reward = (amount * 10) / 100;

        token.transfer(msg.sender, amount + reward);
    }
}