// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ModifiersAndFallbacks {
    address public owner;
    uint public totalReceived;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function updateOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {
        totalReceived += msg.value;
    }

    fallback() external payable {
        // catch-all
        totalReceived += msg.value;
    }
}
