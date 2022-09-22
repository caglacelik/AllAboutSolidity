// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

    // Inheritence
    // Solidity supports multiple inheritance including polymorphism.

    contract A {
        function foo() public virtual returns(string memory) {
            return "A";
        }
    }

    contract B is A {
        // override
        function foo() public pure virtual override returns(string memory) {
            return "B";
        }
    }

    contract C is A {
        function foo() public pure virtual override returns(string memory) {
            return "C";
        }
    }
    
    contract D is B, C {
        // D.foo() returns C
        // since C is the right most parent contract with function foo()

        function foo() public pure override(B, C) returns(string memory) {
            // super calls all parent contracts
            return super.foo();
        }
    }

    contract E is C, B {
        // E.foo() returns "B"
        // since B is the right most parent contract with function foo() 

        function foo() public pure override(C, B) returns(string memory) {
            return super.foo();
        }
    }

        // Inheritance must be ordered from “most base-like” to “most derived”.
        // Swapping the order of A and B will throw a compilation error.
    contract F is A, B {
        function foo() public pure override(A, B) returns(string memory) {
            return super.foo();
        }

    }

        // Interface
        // You can interact with other contracts by declaring an Interface.
        // - cannot have any functions implemented
        // - can inherit from other interfaces
        // - all declared functions must be external
        // - cannot declare a constructor
        // - cannot declare state variables

    contract Counter {
        uint public count;

        function increment() external {
            count +=1;
        }

        function decrement() external {
            count -=1;
        }
    }

    interface ICounter {
        function count() external view returns(uint);
        function increment() external;
        function decrement() external;
    }

    contract MyContract {
        function incrementCounter(address _counter) external {
            ICounter(_counter).increment();
        }

        function decrementCounter(address _counter) external {
            ICounter(_counter).decrement();
        }

        function getCount(address _counter) external view returns (uint) {
            return ICounter(_counter).count();
        }
    }

    contract Test {
        string public message;
        uint public x = 10;

        event Log(string message);

        fallback() external payable {
            emit Log("fallback was called");
        }

        function foo(string memory _message, uint _x) external payable returns(bool, uint) {
            message = _message;
            x = _x;
            return (true, 999);
        }

        function getX() external view returns(uint) {
            return x;
        }

        function setX(uint _x) external {
            x = _x;
        }
    }

    contract Call {
        bytes public data;
        function callFoo(address _test) external payable {
           (bool success, bytes memory _data) = _test.call{value: 111}(abi.encodeWithSignature("foo(string,uint256)", "call foo", 100));
           require(success,"call failed");
           data = _data;
        }

        function callDoesNotExist(address _test) external {
            (bool success, ) = _test.call(abi.encodeWithSignature("doesNotExist()"));
            require(success, "call failed");
        }

        function setX(Test _test, uint _x) external {
            _test.setX(_x);
        }

        function getX(address payable _test) external view returns(uint) {
            return Test(_test).getX();
        }

    }



