// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

        // DATA TYPES

        // BOOLEAN
        // bool
        // With the logical operators ! && || == !=

        // INTEGER
        // int & uint
        // int8 to uint256

        // FIXED POINT NUMBERS
        // Fixed point numbers are not fully supported by Solidity yet. They can be declared, but cannot be assigned to or from.
        // fixed & ufixed
        // (u)fixedMxN 
        // M => size in bits
        // N => number of decimals after the point 

        // CONSTANT
        // named with upper cases
        // save gas when a function is called that uses that state variable
        // can never be changed after compilation

        // IMMUTABLE
        // can be set within the constructor
        // less gas

        // ADDRESS
        // address & address payable
        // Holds a 20 byte value (size of an Ethereum address).
        // ADDRESS PAYABLE: Same as address, but with the additional members transfer and send.
        // The idea behind this distinction is that address payable is an address you can send Ether to, while a plain address cannot be sent Ether.

        // FIXED-SIZE BYTE ARRAY 
        // Fixed size array of bites declared with bytes1 to bytes32 
        // .lenght --> read only

        // DYNAMICALLY-SIZED BYTE ARRAY
        // Variable-sized arrays of bytes declared with BYTES or STRING
        // Reference Types

        // The type byte[] is an array of bytes, but due to padding rules, 
        // it wastes 31 bytes of space for each element (except in storage). It is better to use the bytes type instead.
        // https://arxiv.org/pdf/2108.05513.pdf

        // In Solidity, byte refers to 8-bit signed integers. Everything in memory is stored in bits with binary values 0 and 1.
        // The bytes value type in Solidity is a dynamically sized byte array. It is provided for storing information in binary format.

        // bytes1 uu = 0x45;

        // IMPLICIT CONVERSION
        // Implicit conversion means that there is no need for an operator, or no external help is required for conversion. 
        // These types of conversion are perfectly legal and there is no loss of data or mismatch of values. 
        // They are completely type-safe. 
        // Solidity allows for implicit conversion from smaller to larger integral types. 
        // For example, converting uint8 to uint16 happens implicitly.
        // smaller to larger storages
        // address payable to address
        // https://ethereum.stackexchange.com/questions/72022/type-uint256-is-not-implicitly-convertible-to-expected-type-int256
        // Implicit conversions from address payable to address are allowed, whereas conversions from address to address payable must be explicit via payable(<address>).

        // EXPLICIT CONVERSION // int uint conversion???
        // Explicit conversion is required when a compiler does not perform implicit conversion either 
        // because of loss of data or a value containing data not falling within a target data type range. 
        // Examples of explicit conversion are uint16 conversion to uint8. 
        // Data loss is possible in such cases.
        // Explicit conversions to and from address are allowed for uint160, integer literals, bytes20 and contract types.
        // For contract-type, this conversion is only allowed if the contract can receive Ether, 
        // i.e., the contract either has a receive or a payable function. 
        // Note that payable(0) is valid and is an exception to this rule. 0X0000000000000000
        // int8 to uint256 = ❌ because an uint256 cannot hold negative values that could potentially come from the int8
        // https://betterprogramming.pub/solidity-tutorial-all-about-conversion-661130eb8bec

        // ENUMS
        // Enums are one way to create a user-defined type in Solidity. 
        // They are explicitly convertible to and from all integer types but implicit conversion is not allowed. 
        // Enums require at least one member, and its default value when declared is the first member. 
        // Enums cannot have more than 256 members. 

        // CONTRACT TYPES
        // Every contract defines its own type. 
        // You can implicitly convert contracts to contracts they inherit from. 
        // Contracts can be explicitly converted to and from the address type.

        // REFERENCE TYPES 
        // Values of reference type can be modified through multiple different names. 
        // Contrast this with value types where you get an independent copy whenever a variable of value type is used. 
        // Because of that, reference types have to be handled more carefully than value types. 
        // Currently, reference types comprise structs, arrays and mappings. 
        // If you use a reference type, you always have to explicitly provide the data area where the type is stored.

        // ARRAY & STRING & STRUCT & MAPPINGS
        // There are three data locations: memory, storage and calldata

        // CALL DATA
        // Special data location that contains the function arguments
        // Calldata is a non-modifiable, non-persistent area where function arguments are stored, and behaves mostly like memory. 
        // If you can, try to use calldata as data location because it will avoid copies and also makes sure that the data cannot be modified. 
        // Arrays and structs with calldata data location can also be returned from functions

        // MEMORY
        // Lifetime is limited to an external function call

        // STORAGE
        // The location where the state variables are stored, where the lifetime is limited to the lifetime of a contract

        // DATA LOCATIONS & ASSIGNMENTS
        // Data locations are not only relevant for persistency of data, but also for the semantics of assignments:
        // Assignments between storage and memory (or from calldata) always create an independent copy. 
        // Assignments from memory to memory only create references. 
        // This means that changes to one memory variable are also visible in all other memory variables that refer to the same data.
        // Assignments from storage to a local storage variable also only assign a reference.
        // All other assignments to storage always copy. 

        // ARRAYS 
        // Arrays can have a compile-time fixed size, or they can have a dynamic size.
        // Indices are zero-based, and access is in the opposite direction of the declaration.
        // For example, an array of 5 dynamic arrays of uint is written as uint[][5].
        // In Solidity, X[3] is always an array containing three elements of type X, even if X is itself an array.
        // For example, if you have a variable uint[][5] memory x, you access the second uint in the third dynamic array using x[2][1], 
        // and to access the third dynamic array, use x[2]. 
        // Again, if you have an array T[5]a for a type T that can also be an array, then a[2] always has type T.

        // Array elements can be of any type, including mapping or struct.
        // It is possible to mark state variable arrays public and have Solidity create a getter. 
        // The numeric index becomes a required parameter for the getter.
        // Methods .push(value) can be used to append a new element at the end of the array

        // MEMBERS OF ARRAY
        // push(x)
        // Dynamic storage arrays and bytes (not string) have a member function called push(x) 
        // that you can use to append a given element at the end of the array. The function returns nothing.
        // pop()
        // Dynamic storage arrays and bytes (not string) have a member function called pop that you can use to remove an element from the end of the array. 
        // This also implicitly calls delete on the removed element.
        // length
        // Arrays have a length member that contains their number of elements. 
        // The length of memory arrays is fixed (but dynamic, i.e. it can depend on runtime parameters) once they are created.
        // push()
        // Dynamic storage arrays and bytes (not string) have a member function called push() that you can use to append a zero-initialised element at the end of the array. 
        // It returns a reference to the element, so that it can be used like x.push().t = 2 or x.push() = b.

        // Variables of type BYTES and STRING are special arrays. A BYTES is similar to byte[], but it is packed tightly in calldata and memory. 
        // STRING is equal to BYTES but does not allow length or index access.
        // Solidity does not have string manipulation functions, but there are third-party string libraries.
        // For strings
        // compare => keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2))
        // concat => (bytes(s1), bytes(s2))
        // If you can limit the length to a certain number of bytes, always use one of the value types bytes1 to bytes32 because they are much cheaper.

        // Memory Arrays
        // Push function does not work
        // It is not possible to resize

        // With fixed size arrays push does not work

        // Gas Considerations
        // Estimating Gas Cost
        // Calling other contracts
        // Returning dynamic sized arrays

        // STRUCT
        // User-defined data containers for grouping variables
        // Struct types can be used inside mappings and arrays and they can themselves contain mappings and arrays.
        // It is not possible for a struct to contain a member of its own type, 
        // although the struct itself can be the value type of a mapping member or it can contain a dynamically-sized array of its type. 
        // This restriction is necessary, as the size of the struct has to be finite.
        // Of course, you can also directly access the members of the struct without assigning it to a local variable, 
        // as in campaigns[campaignID].amount = 0

        // STATE VARIABLE VISIBILITY
        // PUBLIC
        // Other contracts can read their values
        // When used within the same contract, the external access (e.g. this.x) invokes the getter 
        // while internal access (e.g. x) gets the variable value directly from storage. 
        // Setter functions are not generated so other contracts cannot directly modify their values.

        // INTERNAL
        // Internal state variables can only be accessed from within the contract they are defined in and in derived contracts. 
        // They cannot be accessed externally. This is the default visibility level for state variables.

        // PRIVATE
        // Private state variables are like internal ones but they are not visible in derived contracts.

        // LValue Def: Variable or something that can be assigned to

        // Time Units
        // 1 == 1 seconds
        // 1 minutes == 60 seconds
        // 1 hours == 60 minutes
        // 1 days == 24 hours
        // 1 weeks == 7 days

        // Ether Units
        // assert(1 wei == 1);
        // assert(1 gwei == 1e9);
        // assert(1 ether == 1e18);

        // PREDEFINED GLOBAL VARIABLES
        // When a contract is executed in EVM, it has access to a small set objects.
        // These include block, msg and tx. 

        // MSG Transaction Message Call Object
        // The msg object is the transaction call or message call that launched this contract execution. 
        // msg.data (bytes calldata): complete calldata
        // msg.sender (address payable): sender of the message (current call)
        // msg.value (uint): number of wei sent with the message

        // TX Transaction Context
        // The tx object provides a means of accessing transaction-related information
        // tx.gasprice (uint): gas price of the transaction
        // tx.origin (address payable): sender of the transaction (full call chain) unsafe!

        // Block Context
        // The block object contains information about the current block
        // blockhash(uint blockNumber) returns (bytes32): hash of the given block - only works for 256 most recent, excluding current, blocks
        // block.chainid (uint): current chain id
        // block.coinbase (address payable): current block miner’s address
        // block.difficulty (uint): current block difficulty
        // block.gaslimit (uint): current block gaslimit
        // block.number (uint): current block number
        // block.timestamp (uint): current block timestamp as seconds since unix epoch

        // MAPPING
        // Mapping types use the syntax mapping(KeyType => ValueType) and variables of mapping type are declared using the syntax 
        // mapping(KeyType => ValueType) VariableName. The KeyType can be any built-in value type, bytes, string, or any contract or enum type. 
        // Other user-defined or complex types, such as mappings, structs or array types are not allowed.
        //  the key data is not stored in a mapping, only its keccak256 hash is used to look up the value.
        // They cannot be used as parameters or return parameters of contract functions that are publicly visible.
        // These restrictions are also true for arrays and structs that contain mappings.

        // ITERATABLE MAPPING
        // You cannot iterate over mappings, i.e. you cannot enumerate their keys. 
        // It is possible, though, to implement a data structure on top of them and iterate over that.


     contract Variables {

         uint8 public muUint = 10;
         bytes public bytesX = hex'0701';

         string public myString = "Hello World";
         bytes32 public myBytes = "Hello World";

         // 21442 gas with constant
         address public constant MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
         uint public constant MY_UINT = 543;

         // 23597 gas without constant
         address public MY_ADDRESS2 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

         address public immutable owner;

         constructor(){
               owner = msg.sender;
          }


        struct MyStruct {
            uint256 index;
            string name;
        }

        MyStruct[] public structs;

        // MyStruct public mystruct = MyStruct(1,"Cagla");

        function compare(string memory s1, string memory s2) public pure returns(bool) {
            return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
        }


        function concat(string memory s1, string memory s2) public pure returns(string memory) {
            return string(abi.encodePacked(s1,s2));
        }

        function addItem(uint i, string memory n) public {
            structs.push(MyStruct(i,n));
        }

        function removeItem() public {
            structs.pop(); 
        }

        function removeItemWithIndex(uint i) public {
            delete structs[i];
        }

        function getLength() public view returns(uint) {
            return structs.length;
        }

        function implicitConversion() public pure returns(uint){
            uint8 y = 10;
            uint16 z = 20;
            uint32 x = y + z;
            return x;
        }

        function explicitConversion() public pure returns (uint){
            int y = -3;
            uint x = uint(y);
            return x;
        }

        function referenceBytesArray() public pure returns(bytes4){
            bytes2 a = 0x1234;
            bytes4 b = bytes4(a); 
            return b;
        }

        function f(uint len) public pure {
        uint[] memory a = new uint[](7);
        bytes memory b = new bytes(len);
        assert(a.length == 6);
        assert(b.length == len);
        a[5] = 10;
        }

            struct People {
            uint ID;
            string name;
        }

        People[] public people;
        mapping(uint256 => string) public nameToNumber;

        function addPerson(uint _ID, string memory _name) public {
            people.push(People(_ID, _name));
            nameToNumber[_ID] = _name;
        }

        mapping(address => uint) public balances;
        mapping(address => mapping(address => bool)) public isFriend;

        function maps() external {
            balances[msg.sender] = 123;
        // uint bal = balances[msg.sender];
        // uint bal2 = balances[address(1)]; // return 0
            balances[msg.sender] += 40;
            delete balances[msg.sender]; // reset to the default value => 0
            isFriend[msg.sender][address(this)] = true;
        }

        function update(uint newBalance) public {
            balances[msg.sender] = newBalance;
        }

        mapping(address => bool) public inserted;
        address[] public keys;

        function setBalance(address _key, uint _value) external {
               balances[_key] = _value;
               if(!inserted[_key]) {
                    inserted[_key] = true;
                    keys.push(_key);
               }
        }

        function getSize() external view returns(uint) {
               return keys.length;
        }

        function firstElement() external view returns (uint) {
               return balances[keys[0]];
        }

        function lastElement() external view returns (uint) {
               return balances[keys[keys.length -1]];
        }

        function getByIndex(uint _i) external view returns (uint) {
               return balances[keys[_i]];
        }

        // STRUCTS

        struct Car {
            string model;
            uint year;
            address owner;
        }

        Car public car;
        Car[] public cars;
        mapping(address => Car[]) public carsByOwner;

        function getCar() external returns(Car memory) {
            Car memory toyota = Car("Toyota", 2000, msg.sender);
            cars.push(toyota);
            return toyota;
        }

        function getCar2() external view returns(Car memory) {
            Car memory lambo = Car({year: 1990, model : "Lamborghini", owner : msg.sender });
            return lambo;
        }

        function getCar3() external returns(Car memory) {
            Car memory tesla;
            tesla.model = "Tesla";
            tesla.year = 2020;
            tesla.owner = msg.sender;
            cars.push(tesla);
            cars.push(Car("Mercedes", 2010, msg.sender));
            return tesla;
        }

        // modifies the first element's year of cars array
        function updateCar() external {
            Car storage _car = cars[0];
            _car.year = 1888;
            // reset the owner address to default value => 0X00000000000..
            delete _car.owner;
            delete cars[1];
        }

        struct Funder {
        address addr;
        uint amount;
        }

        struct Campaign {
        address payable beneficiary;
        uint fundingGoal;
        uint numFunders;
        uint amount;
        mapping (uint => Funder) funders;
        }

        uint numCampaigns;
        mapping (uint => Campaign) campaigns;

        function newCampaign(address payable beneficiary, uint goal) public returns (uint campaignID) {
            campaignID = numCampaigns++; // campaignID is return variable
            // We cannot use "campaigns[campaignID] = Campaign(beneficiary, goal, 0, 0)"
            // because the right hand side creates a memory-struct "Campaign" that contains a mapping.
            Campaign storage c = campaigns[campaignID];
            c.beneficiary = beneficiary;
            c.fundingGoal = goal;
        }

        function contribute(uint campaignID) public payable {
            Campaign storage c = campaigns[campaignID];
            // Creates a new temporary memory struct, initialised with the given values
            // and copies it over to storage.
            // Note that you can also use Funder(msg.sender, msg.value) to initialise.
            c.funders[c.numFunders++] = Funder({addr: msg.sender, amount: msg.value});
            c.amount += msg.value;
        }

        function checkGoalReached(uint campaignID) public returns (bool reached) {
            Campaign storage c = campaigns[campaignID];
            if (c.amount < c.fundingGoal)
                return false;
            uint amount = c.amount;
            c.amount = 0;
            c.beneficiary.transfer(amount);
            return true;
        }

    }