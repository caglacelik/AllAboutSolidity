// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Events {
    // Solidity Events are the same as events in any other programming language. 
    // An event is an inheritable member of the contract, which stores the arguments passed in the transaction logs when emitted.
    // Index in events: We can also add an index to our event. On adding the different fields to our event, we can add an index to them it helps to access them later but of course, it’s going to cost some more gas!

    // When you call them, they cause the arguments to be stored in the transaction’s log - a special data structure in the blockchain. 
    // These logs are associated with the address of the contract, are incorporated into the blockchain, and stay there as long as a block is accessible
    // The Log and its event data is not accessible from within contracts
    // It is possible to request a Merkle proof for logs, so if an external entity supplies a contract with such a proof, it can check that the log actually exists inside the blockchain. 
    // You have to supply block headers because the contract can only see the last 256 block hashes.
    // You can add the attribute indexed to up to three parameters which adds them to a special data structure known as “topics” instead of the data part of the log.
    // All parameters without the indexed attribute are ABI-encoded into the data part of the log.

    // https://docs.soliditylang.org/en/v0.8.17/contracts.html#members-of-events

    event Log(string message, uint val);
    event IndexedLog(address indexed sender, uint val);

    function  logging() external { // transactional function
        emit Log("foo", 1234);
        emit IndexedLog(msg.sender, 80);
    }

    event Message(address indexed _from, address indexed _to, string message);

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }

    // Members
    // event.selector: For non-anonymous events, this is a bytes32 value containing the keccak256 hash of the event signature, as used in the default topic.

        event Deposit(
        address indexed from,
        bytes32 indexed id,
        uint value
    );

    function deposit(bytes32 id) public payable {
        emit Deposit(msg.sender, id, msg.value);
    }

}