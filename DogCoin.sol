// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract DogCoin {
    uint totalSupply = 2000000000000000000000000; //18 decimals 000000000000000000
    address owner;
    // set up a variable called balances to keep track of the number of tokens that a user have
    mapping (address => uint ) public balances;

    // have a payments array for each user sending the payment
    mapping (address => Payment[]) public PaymentArray;

    Payment[] public senderPaymentArray;

    // Create a constructor to initialise the state of the contract and within the constructor, store the owner's address.
    // Give all of the total supply to the owner of the contract.
    constructor () {
        owner = msg.sender;
        // give all of the total supply to the owner of the contract.
        balances[owner] = totalSupply;
    }

    // keep a record for each user's transfers.
    // Create a struct called Payment that stores the transfer amount and the recipient's address
    struct Payment {
        address recipient;
        uint256 amount;
    }

    // Create a modifier which only allows an owner to change the total supply
    modifier onlyOwner {
        require(owner == msg.sender,
                "Only owner can call this function"
        );
        _;
    }
    //  Create an event that emits the new value whenever the total supply changes. When the supply changes, emit this event.
    event supplyChange (
        uint totalSupply
    );
    // . Add an event to the transfer function to indicate that a transfer has taken place, it should log the amount and the recipient address.
    event Transfer (address recipient, uint256 amount);

    // Make a public function that returns the total supply
    function getTotalSupply () public view returns (uint _totalSupply){
        _totalSupply = totalSupply;
        return _totalSupply;
    }

    //  Make a public function that can increase the total supply in steps of 1000.
    function increaseTotalSupply () public onlyOwner {
        totalSupply += 1000000000000000000000;
        emit supplyChange(totalSupply);
    }

    // Allow the balances variable to be read from the contract
    // 2 ways? Get value by . (method) or [] (slice) 
    function getBalance(address user) public view returns(uint){
        return balances[user];
    }

    // Why do we not need the sender's address here ?
    // Because msg.sender is a predefined global variable
    // What would be the implication of having the sender's address as a parameter ?
    // To ensure that only authorized senders can interact with the contract.
    function transfer( address recipient, uint256 amount) public {
        require(msg.sender != address (0));
        require(recipient != address (0));
        require(balances[msg.sender] >= amount);

        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        recordPayment(msg.sender, recipient, amount);
        emit Transfer(recipient, amount);
    }

    function recordPayment(address sender, address recipient, uint amount) internal {
            // PaymentArray[sender] = senderPaymentArray.push(Payment(recipient, amount));
        senderPaymentArray.push(Payment(recipient, amount));
        PaymentArray[sender] = senderPaymentArray;
    }

}
