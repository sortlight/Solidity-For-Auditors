
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VisibilityStorage {
    uint public total;
    uint private secretCode;

    function add(uint x) public {
        total += x;
    }

    function getSecretCode() external view returns (uint) {
        return secretCode;
    }

    function updateSecretCode(uint x) public {
        secretCode = x;
    }

    function internalOnly() internal pure returns (string memory) {
        return "I'm internal!";
    }

    function whoCanCallMe() pure public returns (string memory) {
        return "Anyone!";
    }
}