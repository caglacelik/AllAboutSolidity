// SPDX-License-Identifier: GPL-3.0

        // orange button : changing on contract + must pay gas fee
        // green button : only reading event

        // Visibility & Modifiers

        // PUBLIC 
        // Public functions are part of the contract interface and can be either called internally or via messages. 
        // For public state variables, an automatic getter function is generated.

        // PRIVATE
        // Private functions and state variables are only visible for the contract they are defined in and not in derived contracts.

        // INTERNAL
        // Those functions and state variables can only be accessed internally 
        // (i.e. from within the current contract or contracts deriving from it), without using this.

        // EXTERNAL
        // External functions are part of the contract interface, 
        // which means they can be called from other contracts and via transactions. 
        // An external function f CAN NOT be called internally (i.e. f() does not work, but this.f() works). 
        // External functions are sometimes more efficient when they receive large arrays of data, 
        // because the data is not copied from calldata to memory. 

        // STATE MUTABILITY
        // State mutability is a concept in solidity that defines the behaviour of functions and 
        // how they interact with data stored on the blockchain. 
        // https://ethereum.stackexchange.com/questions/103408/function-state-mutability


        // STATE MUTABILITY MODIFIERS

        // VIEW --> read-only & not modify state
        // Functions can be declared VIEW in which case they promise not to modify the state.
        // CAN NOT receive or send ether and can ONLY CALL other view or pure functions

        // PURE --> not read & not modify state
        // Functions can be declared pure in which case they promise not to read from or modify the state.

        // PAYABLE --> mandatory when sending & receiving ETH 
        // Declaring a function with the payable keyword allows the function to send and receive ether. 
        // Attempting to send or receive ether through a function that is not marked as payable will result in a rejected transaction.
        // ex: deposit(), withdraw()

        // NON-PAYABLE --> DEFAULT STATE MUTABILITY if it is not defined PAYABLE
        // Non-payable functions not explicitly defined as view or pure are best suited for functions 
        // that potentially read and modify state variables. 
        // The major limitation to non-payable functions is their inability to receive or send ether.
        
        // Why should you mark your functions as view or pure?
        // Gas Optimization
        // Gas consumption only applies when a transaction is triggered and transactions are triggered when state is modified. 
        // Functions marked as view or pure do not modify state, 
        // hence do not cost gas, unless they are called from external contracts.
        
        //https://medium.com/coinmonks/function-state-mutability-in-solidity-acb850eedccc#:~:text=State%20mutability%20is%20a%20concept,in%20writing%20optimized%20smart%20contracts.

        // GETTER FUNCTIONS
        // The compiler automatically creates getter functions for all public state variables
        // The getter functions have external visibility. If the symbol is accessed internally (i.e. without this.), it evaluates to a state variable. 
        // If it is accessed externally (i.e. with this.), it evaluates to a function.

        // FUNCTION MODIFIERS
        // Modifiers can be used to change the behaviour of functions in a declarative way. 
        // For example, you can use a modifier to automatically check a condition prior to executing the function.
        // Modifiers are inheritable properties of contracts and may be overridden by derived contracts, but only if they are marked virtual.
        // Note: We can apply multiple modifiers to functions by placing them in a whitespace-separated list and they are evaluated in the order presented.
        // You can write a modifier with or without arguments. If the modifier does not have argument, you can omit the parentheses () .

        // THE _; SYMBOL
        // The symbol _; is called a merge wildcard. 
        // It merges the function code with the modifier code where the _; is placed.
        // We can place the _; at the beginning, middle or the end of your modifier body.
        // In practice, (especially until you understand how modifiers work really well), the safest usage pattern is to place the _; at the end.

        // SENDING ETHER
        // You can send Ether to other contracts by
        // transfer(address payable to) 2300 gas, throws error
        // send(address payable to) 2300 gas, returns bool
        // call(address payable to) forward all gas or set gas, returns bool

        // RECEIVING ETHER
        // A contract receiving Ether must have at least one of the functions below
        // fallback() external payable
        // receive() external payable


        // FALLBACK FUNCTION
        // What is the aim of the fallback function?
        // Coin management = accept and allocate coins in a meaningful manner.
        // Error-handling = if a user calls a function in a contract that does not exists, the fallback function will be executed.

        // A contract can have at most one fallback function, declared using either fallback () external [payable] or 
        // fallback (bytes calldata input) external [payable] returns (bytes memory output) (both without the function keyword). 
        // This function must have external visibility. A fallback function can be virtual, can override and can have modifiers.
        // The fallback function always receives data, but in order to also receive Ether it must be marked payable.
        // It is executed either when;
        // a function that does not exist is called 
        // Ether is sent directly to a contract but receive() does not exist or msg.data is NOT EMPTY

        // RECEIVE ETHER FUNCTION
        // A contract can have at most one receive function, declared using receive() external payable { ... } (without the function keyword). 
        // This function cannot have arguments, cannot return anything and must have external visibility and payable state mutability. 
        // It can be virtual, can override and can have modifiers.
        // The receive function is executed on a call to the contract with empty calldata. 
        // This is the function that is executed on plain Ether transfers (e.g. via .send() or .transfer()).

        // receive() is called if msg.data is EMPTY, otherwise fallback() is called

        contract ReceiveEther {

                    // Which function is called, fallback() or receive()?

                            //            send Ether
                            //                |
                            //          msg.data is empty?
                            //               / \
                            //             yes  no
                            //             /     \
                            // receive() exists?  fallback()
                            //          /   \
                            //         yes   no
                            //         /      \
                            //     receive()   fallback()

        // Function to receive ether. msg.data must be EMPTY
        receive() external payable {}

        // Fallback function is called when msg.data is NOT EMPTY
        fallback() external payable {}

        function getBalance() public view returns(uint) {
            return address(this).balance;
        }
    }

    contract SendEther {

        function sendTransfer(address payable _to) public payable {
            _to.transfer(msg.value);
        }

        function sendSend(address payable _to) public payable {
           bool sentOrNot = _to.send(msg.value);
           require(sentOrNot, "Process failed!");
        }

        function sendCall(address payable _to) public payable {
           (bool sentOrNot,) = _to.call{value: msg.value}("");
           require(sentOrNot, "Process failed!");
        }

    }

        // Why undefined & null does not exist in Solidity ?
        // Solidity is a statically typed language, which means that the state or local variable type needs to be specified during declaration. 
        // Each declared variable always have a default value based on its type. There is no concept of "undefined" or "null".

        // MEMORY & STORAGE
        // https://medium.com/coinmonks/ethereum-solidity-memory-vs-storage-which-to-use-in-local-functions-72b593c3703a

        // DEBUG
        // https://remix-ide.readthedocs.io/en/latest/debugger.html

        // Q&A
        // https://ethereum.stackexchange.com/
        // https://forum.openzeppelin.com/

        // DOCS
        // https://docs.soliditylang.org/en/v0.8.0/cheatsheet.html

        // NULL CHECK 
        contract X {
        enum EmployeeType {
            Employee,
            Contractor,
            PartTime
            }

            struct Person {
            EmployeeType employeeType;
            bool deleted;
            string name;
            uint256 yearOfBirth;
            address walletAddress;
            uint256[] doorAccess;
            }


        function check() public pure {
        Person memory person;
        require(bytes(person.name).length == 0);
        person.yearOfBirth == 0;
        person.walletAddress == address(0);
        person.employeeType == EmployeeType.Employee;
        person.doorAccess.length == 0;
            }    
        }

pragma solidity ^0.8.0;

    contract Functions {
         uint public number = 7; // number is a state variable that stored in blockchain / contract storage
         uint public x = 50;

         function typeOf() public view returns(uint){
             return x;
         }

         function setX(uint newX) public { // newX is local variable
             x = newX;
         } 

         function add() public view returns(uint){
             return block.timestamp; // block is global variable
         }

         function setNumber(uint newNumber) public {
             number = newNumber;
         }

         function displayItems() public pure returns(uint num, bool tr, string memory name){
             num = 5;
             tr = true;
             name = "Cagla";
         }

         function displayItems2() public pure returns(uint, bool, string memory){
             return(5,true,"Cagla");
         }

         function callDisplayItems() public pure returns(uint, bool, string memory){
            return displayItems();
         }

         function privateKey() private pure returns(string memory){
             return "This is private key";
         }

         function callPrivateKey() public pure returns(string memory){
             return privateKey();
         }

         function internalKey() internal pure returns(string memory){
             return "This is internal key";
         }

         function callInternalKey() public pure returns(string memory){
             return internalKey();
         }

         function externalKey() external pure returns(string memory){
             return "This is external key";
         }

         function callExternalKey() public view returns(string memory){
             return this.externalKey();
         }

         uint[][] public arr2D = [[1],[3]];

         
    }

    contract Modifiers {
        address public owner;
        uint private index = 1; 
        
        // modifier for checking whether message caller is owner or not
        modifier onlyOwner() {
            require(msg.sender == owner, 'Only owner!');
            _; 
        }
    
        // setting msg.sender as the owner
        constructor() {
            owner = msg.sender;
        }
        
        //  applying modifier, only owner can execute this function
        //  we can use 'onlyOwner' instead of 'onlyOwner()', both are same
        function add() internal onlyOwner {
            index ++;
        }
        
        //  applying multiple modifiers
        //  modifier a() {...}
        //  modifier b() {...}
        //  function foo() public a() b() {...}

        // different version

        function isOkay() public pure returns(bool) {
            // do some validation checking
            return true;
        }
        function isAuthorised(address _user) public pure returns(bool) {
            // logic that checks that _user is authorised
            _user = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
            return true; 
        }
        modifier OnlyIfOkAndAuthorised {
            require(isOkay());
            require(isAuthorised(msg.sender));
            _;
        }
        modifier validAddress(address _addr) {
            require(_addr != address(0), "Not valid");
            _;
        }
    }



