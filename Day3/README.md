# Day 3 – Inheritance, Interfaces & Extensibility

Today we enter Solidity’s version of “family business.”

Inheritance and interfaces are how contracts share responsibilities, mess things up for each other or completely forget to do the dishes (read: protect functions). As an auditor, this is where you look for unexpected behavior that no one intended but attackers love.

---

## 1. Inheritance – When Contracts Borrow From Their Parents

Solidity lets a contract reuse functions and variables from other contracts. This is great for saving time and also for accidentally exposing stuff you didn’t mean to.

### Sample Code

```solidity
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

```

In this case, the Child contract automatically has sayHello() from Parent. It didn’t ask for it. It just inherited it.

## Auditor Danger Zone: Inheritance

| Issue                 | What It Looks Like                                         |
| --------------------- | ---------------------------------------------------------- |
| Function override     | A child silently changes the parent’s logic                |
| Missing modifiers     | Inherited functions aren’t access-controlled               |
| Constructor confusion | Child doesn’t call parent constructor                      |
| Variable shadowing    | Parent’s `admin` is replaced by child’s `admin` — silently |


## 2. Interfaces: Contracts Talking To Other Contracts (Blindly)

An interface is a contract without any logic just like saying “Trust me, I’ll call this function and it’ll just work.”

```solidity

interface IToken {
    function transfer(address to, uint amount) external returns (bool);
}

```

Interfaces are often used to call external contracts (DeFi, ERC20s, bridges). That is super cool until the external contract doesn’t behave the way your interface expects.

Sample Mistake:

Interface says transfer() returns bool

Real token (some non-standard ERC20) doesn’t return anything

Your contract doesn’t check the return value

Funds don’t transfer — but the contract thinks it did

## 3. Example: Inheritance Meets Interface... and Bugs Happen

```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

```

## What Could Go Wrong Here?

setAdmin() is exposed which means no onlyAdmin modifier. Anyone can hijack the admin role.

The external interface assumes that deposit() returns bool. If someone later changes that interface or forgets to check the return value, logic silently fails.

A real attacker could use this to:

Become the admin

Withdraw or redirect funds if other admin-only functions exist.

## Audit Checklist

 Are inherited functions overridden safely?

 Are inherited functions protected with modifiers?

 Are parent constructors being initialized?

 Is the interface function signature accurate?

 Are interface return values being properly handled?

 Any variable shadowing between child and parent?


## Up Next

Tomorrow we dive into the black box of events to know how logs tell stories on-chain, and how you can trace a contract’s real behavior by what it emits.

# Author

Written by [Sortlight](https://github.com/sortlight)


`
                                                                         Go to: Day 4 – Events, Logs, and Attack Traces →
