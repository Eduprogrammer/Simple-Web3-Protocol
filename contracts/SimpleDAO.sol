// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./MyToken.sol";

contract SimpleDAO {
    MyToken public token;

    uint public votesYes;
    uint public votesNo;

    mapping(address => bool) public voted;

    constructor(address _token) {
        token = MyToken(_token);
    }

    function vote(bool _vote) public {
        require(!voted[msg.sender], "Ja votou");

        uint power = token.balanceOf(msg.sender);
        require(power > 0, "Sem poder de voto");

        voted[msg.sender] = true;

        if (_vote) {
            votesYes += power;
        } else {
            votesNo += power;
        }
    }
}