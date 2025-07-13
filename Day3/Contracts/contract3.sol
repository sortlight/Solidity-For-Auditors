// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// Interface for an external bank contract
interface IBank {
    function deposit(uint amount) external returns (bool);
}

// Parent contract with admin logic
contract Base {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    // This function SHOULD be protected but isn't
    function setAdmin(address newAdmin) public virtual {
        admin = newAdmin;
    }
}

// This contract inherits from Base and implements IBank
contract MyBank is Base, IBank {
    mapping(address => uint) public balances;

    // OVERRIDING THE PARENT FUNCTION
    // But still no modifier - anyone can call this and change admin
    function setAdmin(address newAdmin) public override {
        admin = newAdmin;
    }

    // Accepting deposits from external users
    function deposit(uint amount) external override returns (bool) {
        balances[msg.sender] += amount;
        return true;
    }
}
