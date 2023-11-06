// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Vault {
    mapping(bytes4 => address) public routes;
    mapping(address => bool) public operators;

    constructor(
        bytes4 functionSelectors,
        address targetContracts,
        address allowedOperators
    ) {
        routes[functionSelectors] = targetContracts;
        operators[allowedOperators] = true;
    }

    fallback() external payable {
        bytes4 functionSelector = bytes4(msg.data[:4]);
        address target = routes[functionSelector];

        require(target != address(0), "Route not found");
        require(operators[msg.sender], "Sender not allowed");

        (bool success, ) = target.delegatecall(msg.data);
        require(success, "Delegatecall failed");
    }

    receive() external payable {}
}
