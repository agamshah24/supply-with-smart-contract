pragma solidity ^0.6.9;

// Define Supply chain contract "LemonadeContract"
contract LemonadeStand {

    // Variable: 'Owner'
    address owner;

    // Variable: 'skuCount'
    uint skuCount;

    // Enum: 'State' with values 'ForSale' (State: For sale)
    enum State {ForSale, Sold}

    // Struct: 'Item' with the following fields: name, sku, price, state, seller, buyer
    struct Item {
        string name;
        uint sku;
        uint price; // price is not going to be negative so we used uint.
        State state;
        address seller;
        address buyer;
    }

    // Mapping: Assign 'Item' a SKU
    // Define mapping 'items' that maps the SKU (a number) to an Item.
    mapping (uint => Item) items;

    // Event ForSale
    event ForSale(uint skuCount);

    // Event Sold
    event Sold(uint sku);

    // Modifier: Only Owner to see if msg.sender == owner of the contract.
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Modifier: Verify Caller
    modifier verifyCaller(address _address) {
        require(msg.sender == _address);
        _;
    }

    // Modifier: Paid Enough - It checks if the paid amount is sufficient to cover the price
    modifier paidEnough(uint _price) {
        require(msg.value >= _price);
        _;
    }

    // Modifier: For Sale - It checks if an item.state of a sku is ForSale
    modifier forSale(uint _sku) {
        require(items[_sku].state == State.ForSale);
        _;
    }

    // Modifier: Sold - It checks if an item.state of a sku is Sold
    modifier sold(uint _sku) {
        require(items[_sku].state == State.Sold);
        _;
    }

    // Function: Constructor to set some initial values
    constructor() public {
        owner = msg.sender;
        skuCount = 0;
    }

    // Function: Add Item
    function addItem(string memory _name, uint _price) onlyOwner public {
        // Increment sku
        skuCount = skuCount + 1;

        // Emit the appropriate event
        emit ForSale(skuCount);

        // Add new Item into inventory and mark it for sale
        items[skuCount] = Item({name: _name,sku: skuCount, price: _price, state: State.ForSale, seller: msg.sender, buyer: 0});        
    }

// Function: Buy Item

// Function: Fetch Item

}