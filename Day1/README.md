# Day 1 – Visibility & Storage in Solidity

This module focuses on how access to functions and variables is controlled in Solidity. As a smart contract auditor, understanding visibility and storage isn’t just about code correctness — it’s about identifying the subtle ways code unintentionally exposes data and logic.

---

## Function Visibility: Who Can Call What?

Each function in Solidity must declare its visibility. If not vulnerabilities creep in silently and codedly

| Visibility   | Who Can Call It             | Audit Insight                                   |
|--------------|-----------------------------|-------------------------------------------------|
| `public`     | Anyone (including contracts) | Most dangerous if logic isn’t protected         |
| `private`    | Only this contract           | Still visible on-chain (raw storage inspection) |
| `internal`   | This + inherited contracts   | Can be misused if inherited without review      |
| `external`   | Only outside the contract    | Ideal for APIs and external calls               |

### Diagram: Visibility Flow

![Function Visibility Diagram](./diagrams/function-visibility.png)

---

## Storage Concepts in Solidity

Solidity variables are either temporary (in memory) or permanent (in storage). Knowing where values live helps you predict gas costs, attack surfaces and what’s readable on-chain. isnt that cool?

| Storage Type | Location     | Description                                  |
|--------------|--------------|----------------------------------------------|
| `storage`    | On-chain     | Persistent state, expensive, visible         |
| `memory`     | RAM (EVM)    | Temporary, cheap, cleared after execution    |
| `calldata`   | Input buffer | Read-only input from external calls          |

---



## Example Contract: [Contract](contracts/VisibilityStorage.sol)



```

## What to Observe

secretCode is private but it can still be read on-chain using tools.

Anyone can call updateSecretCode() — dangerous if it guards logic.

internalOnly() can't be called externally — you can try it!

Check the gas when you run add() in Remix vs a view function.


### Function Visibility
- `public`: callable by anyone
- `private`: only this contract
- `internal`: this + inherited contracts
- `external`: callable from outside only

### State Variables
- Stored permanently on-chain
- Access controlled by visibility
- Can be inspected even if private (with tools)

### Storage vs Memory
- `storage`: persistent and expensive
- `memory`: temporary, cheaper
- `view`/`pure`: do not modify state (safe functions)

---

## Sample Contract: VisibilityStorage.sol

Open the file in Remix and try:

1. Calling each function:
   - What fails?
   - What stores new data?
2. Editing visibility:
   - Remove visibility on a function — what happens?
3. Storage view:
   - Use Remix’s "Storage" tab to inspect how `total` and `secretCode` change

---

## Audit Perspective:

- Are state-changing functions protected?
- Are private variables truly hidden?
- Could this contract be manipulated if deployed?

---

## Reflection:

        “I see contracts not as code, but as potential for strength or breach.”

