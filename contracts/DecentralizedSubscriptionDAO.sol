// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SubscriptionDAO {
    struct Creator {
        address wallet;
        uint256 totalReceived;
        bool isRegistered;
    }

    struct Subscriber {
        uint256 amountPaid;
        uint256 lastPaid;
    }

    mapping(address => Creator) public creators;
    mapping(address => Subscriber) public subscribers;

    uint256 public monthlyFee;
    address public owner;

    constructor(uint256 _monthlyFee) {
        monthlyFee = _monthlyFee;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this.");
        _;
    }

    function registerCreator(address _creator) external onlyOwner {
        require(!creators[_creator].isRegistered, "Already registered");
        creators[_creator] = Creator(_creator, 0, true);
    }

    function subscribe() external payable {
        require(msg.value >= monthlyFee, "Insufficient subscription fee");
        subscribers[msg.sender].amountPaid += msg.value;
        subscribers[msg.sender].lastPaid = block.timestamp;
    }

    function distributeFunds(address _creator, uint256 _amount) external onlyOwner {
        require(creators[_creator].isRegistered, "Creator not registered");
        require(address(this).balance >= _amount, "Insufficient balance");
        creators[_creator].totalReceived += _amount;
        payable(_creator).transfer(_amount);
    }

    function updateMonthlyFee(uint256 _newFee) external onlyOwner {
        monthlyFee = _newFee;
    }
}
