//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract MyContract {
    address public owner;
    uint8 public myStateVariable = 5;
    string public myString = "Greetings";
    address public myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    bytes32 public myBytes32 = "1";
    Person public myStruct;
    uint[] public myArray = [1, 2, 3];
    uint[][] public my2dArray = [ [1, 2, 3], [4, 5, 6] ];
    string[] public myStringArray = ["apple", "carrot", "pineapple"];

    struct Person {
        uint id;
        string name;
        uint age;
    }

    struct Book {
        uint id;
        string title;
        string author;
    }

    mapping(uint => Person) public people;
    mapping(address => mapping(uint => Book)) public books;

    constructor() {
        owner = msg.sender;
        myStruct = Person(1, "Anuradha Weeraman", 40);
        people[myStruct.id] = myStruct;
    }
    
    function addPerson(uint _id, string memory _name, uint _age) public {
        people[_id] = Person(_id, _name, _age);
    }

    function addBook(uint _id, string memory _title, string memory _author) public {
        books[msg.sender][_id] = Book(_id, _title, _author);
    }

    function getBooks(address _address, uint _id) public view returns (Book memory) {
        return books[_address][_id];
    }

    function appendFruit(string memory fruit) public {
        myStringArray.push(fruit);
    }

    function stringArrayLength() public view returns (uint) {
        return myStringArray.length;
    }

    function getLocalVariable() public pure returns (uint) {
        uint localVariable = 10;
        return localVariable;
    }

    function increment() public {
        myStateVariable++;
    }

    function isEvenNumber(uint _number) public view returns(bool) {
        if (_number % 2 == 0) {
            return true;
        } else {
            return false;
        }
    }

    function getTotalOfArray() public view returns(uint) {
        uint total;
        for (uint i = 0; i < myArray.length; i++) {
            total += myArray[i];
        }
        return total;
    }

    function isOwner() public view returns (bool) {
        return owner == msg.sender;
    }
}
