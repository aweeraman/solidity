//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Ownable {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier notOwner() {
        require(msg.sender != owner, "Owner cannot book");
        _;
    }
}

contract HotelRoom is Ownable {
    address public occupiedBy;

    enum Statuses { Occupied, Vacant }
    Statuses occupancyStatus;

    event Occupy (address _address, uint _value);
    event Checkout (address _address);

    constructor() {
        occupancyStatus = Statuses.Vacant;
    }

    modifier notOccupied() {
        require(occupancyStatus != Statuses.Occupied, "Room is already occupied");
        _;
    }

    modifier isOccupier() {
        require(occupiedBy == msg.sender, "Room is occupied by someone else");
        _;
    }

    receive() external payable notOwner notOccupied {
        occupiedBy = msg.sender;
        occupancyStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }

    function checkout() public isOccupier {
        occupancyStatus = Statuses.Vacant;
        emit Checkout(msg.sender);
    }

    function ownerBalance() public view returns (uint) {
        return owner.balance;
    }
}
