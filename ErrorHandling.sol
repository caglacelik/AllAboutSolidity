// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ErrorHandling {

    // An error will undo all changes made to the state during a transaction.

    // Errors in Solidity provide a convenient and gas-efficient way to explain to the user why an operation failed. 
    // They can be defined inside and outside of contracts (including interfaces and libraries).
    // They have to be used together with the revert statement which causes all changes in the current call to be reverted and passes the error data back to the caller.

    // Errors cannot be overloaded or overridden but are inherited. The same error can be defined in multiple places as long as the scopes are distinct. 
    // Instances of errors can only be created using revert statements.

    // Note that an error can only be caught when coming from an external call, reverts happening in internal calls or inside the same function cannot be caught.

    // The statement require(condition, "description"); would be equivalent to if (!condition) revert Error("description") 
    // if you could define error Error(string). Note, however, that Error is a built-in type and cannot be defined in user-supplied code.

    // Members
    // error.selector: A bytes4 value containing the error selector.

    // Use custom error to save gas.

    // You can throw an error by calling require, revert or assert.

    // require is used to validate inputs and conditions before execution.
    // revert is similar to require.
    // assert is used to check for code that should never be false. Failing assertion probably means that there is a bug.

    function testRequire(uint _i) public pure {

    // Require should be used to validate conditions such as:
    // inputs
    // conditions before execution
    // return values from calls to other functions

        require(_i > 10,"Input must be greater than 10");
    }

    function testRevert(uint _i) public pure {

    // Revert is useful when the condition to check is complex.
    // This code does the exact same thing as the example above 

        if (_i <= 10)   revert("Input must be greater than 10");
    }

    uint public num;

    function testAssert() public view {

    // Assert should only be used to test for internal errors,
    // and to check invariants.

    // Here we assert that num is always equal to 0
    // since it is impossible to update the value of num

        assert(num == 0);
    
    }

    // custom version
    error InsufficientBalance(uint balance, uint withdrawAmount); 

    function testCustomError(uint _withdrawAmount) public view {
        uint bal = address(this).balance;
        if (bal < _withdrawAmount) revert InsufficientBalance({balance: bal, withdrawAmount : _withdrawAmount});
    }

    uint public balance;
    uint public constant MAX_UINT = 2**256 - 1;

    function deposit(uint _amount) public {
        uint oldBalance = balance;
        uint newBalance = balance + _amount;

        require(newBalance >= oldBalance, "Overflow");

        balance = newBalance;

        assert(balance >= oldBalance);
    }

    function withdraw(uint _amount) public {
        uint oldBalance = balance;

        require(balance >= _amount, "Underflow");

        if (balance < _amount) {
            revert("Underflow");
        }

        balance -= _amount;

        assert(balance <= oldBalance);
    }

}