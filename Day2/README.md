# Day 2 – Modifiers, Fallbacks & Hidden Entry Points

Smart contracts don’t just break from bugs if you know what I mean. They get exploited through the functions most devs overlook. 

Today, we will definitely explore two major gateways that often become entry points for attackers: **modifiers** and **fallbacks**.



## Modifiers: The First Line of Defense

Modifiers are reusable pieces of logic that run **before** your function body.

### Syntax

```solidity
modifier onlyOwner() {
    require(msg.sender == owner, "Not authorized");
    _;
}

```

You apply a modifier to a function like this:

```solidity
function withdraw() public onlyOwner {
    // withdrawal logic
}

```

## Why Modifiers Matter to Auditors

* Checkpoint Example	                -         Explanation

Is the modifier applied?	            -       Functions like withdraw() or mint() must be protected

Is the logic sound?	                    -        Are the checks actually verifying the right condition?

Are multiple modifiers conflicting?	    -        Could logic from one override the other?

Are require statements clear?	        -       Vague errors make debugging and auditing harder


## Fallbacks & Receive: The Ghost Functions

These are hidden entry points. Very often ignored during development but exploited during audits or attacks.

  1. receive() Function

Triggered when a contract receives ETH without any calldata.

```Solidity
receive() external payable {
    // ETH-only logic
}

```

  2. fallback() Function

Triggered when:

    Function signature does not exist

    Data is sent but not matched

    No receive() function is defined


```solidity
fallback() external payable {
    // catch-all logic
}

```

## Audit Insights

What to Watch For	                        -        Why It Matters

Does the fallback function change state?	-       Might allow unintended side effects

Is gas usage controlled?	                -       Can be exploited for gas griefing

Are external calls made from fallback?	    -        Possible reentrancy attack window

Is ether being sent with no purpose?	    -        Can mess with accounting, trigger unexpected behavior


# Audit Checklist

 Are critical functions like updateOwner() and withdraw() properly guarded?

 Can the fallback function be triggered maliciously?

 Does receive() update state safely and predictably?

 Can gas griefing or reentrancy occur through fallback?


 ## Author

 Written by [Sortsec](x.com/sortsec)


## Next 


                                                                      Continue to Day 3: Interfaces, Inheritance & Extensibility →
