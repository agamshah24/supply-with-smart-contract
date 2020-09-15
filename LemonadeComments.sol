pragma solidity ^0.6.9;

// Define Supply chain contract "LemonadeContract"
contract LemonadeStand {

    // Variable: 'Owner'
    address owner;

    // Variable: 'skuCount'
    uint skuCount;

    // Enum: 'State' with values 'ForSale' (State: For sale)
    enum State {ForSale, Sold, Shipped}

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

    // Event Shipped
    event Shipped(uint sku);

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
        items[skuCount] = Item({name: _name,sku: skuCount, price: _price, state: State.ForSale, seller: msg.sender, buyer: address(0)});        
    }

    // Function: Buy Item
    function buyItem(uint _sku) forSale(_sku) paidEnough(items[_sku].price) public payable {
        address buyer = msg.sender;
        uint price = items[_sku].price;
        // Update the buyer
        items[_sku].buyer = buyer;
        // Update the state
        items[_sku].state = State.Sold;
        // Transfer money to seller
        payable(items[_sku].seller).transfer(price);
        // emit the appropriate even
        emit Sold(_sku);
    }

    // Function: Fetch Item
    function fetchItem(uint _sku) view public returns(string memory name, uint sku, uint price, string memory stateIs, address seller, address buyer) {
        uint state;
        name = items[_sku].name;
        sku = items[_sku].sku;
        price = items[_sku].price;
        state = uint(items[_sku].state);
        if (state == 0) {
            stateIs = "For Sale";
        } else if (state == 1) {
            stateIs = "Sold";
        }
        seller = items[_sku].seller;
        buyer = items[_sku].buyer;
    }

    // ShipItem allows owner to change the state of an Item to "Shipped"
    function shipItem(uint _sku) public sold(_sku) verifyCaller(items[_sku].seller) {
        // Update the state
        items[_sku].state = State.Shipped;
        // Emit the appropriate even
        emit Shipped(_sku);
    }
}