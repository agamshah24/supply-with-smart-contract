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

// Modifier: Only Owner

// Modifier: Verify Caller

// Modifier: Paid Enough

// Modifier: For Sale

// Modifier: Sold

// Modifier: Only Owner

// Function: Constructor to set some initial values

// Function: Add Item

// Function: Buy Item

// Function: Fetch Item

}