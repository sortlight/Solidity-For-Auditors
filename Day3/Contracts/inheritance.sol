// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Parent {
    function sayHello() public pure returns (string memory) {
        return "Hi from Parent!";
    }
}

contract Child is Parent {
    function greet() public pure returns (string memory) {
        return "Hello from Child!";
    }
}
