// IF YOU DON'T CODE YOU DON'T LEARN //

// Basic featues of our current app

// Products // how to get & set products
// Carts // how to get & set carts of a user
// Checkout => to get total

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


/*
what we try to build 
A website for selling courses  
*/ 


contract Ecommerce {

    // create a products
    // how our products are going to be stored

    // description => string
    // imageURl => string
    // author => string
    // title => string
    // price => uint
    // id => uint

    // string = "is a data type which used to hold array of chars"
    // uint =  holding the numric values 0-2**256

    // there is no decimals in solidity

    // State variable // cost you a gas fee whenever you update it // global


    uint public ID = 0; // used as primary key

    // user define datatype we use struct to define it
    struct Product {
        string description;
        string imageURl;
        string author;
        string title; 
        uint price; // price is in USD
        uint id;
    } 

    // arrays 
    // syntax => type of variable[] modifier nameOfVariable
    // uint [] public arr 
    // eg: arr = [1,2,3] => arr[0] => indexing starts from 0

    Product[] public products; // dynamic length array means we can add any number of products

    // adding products

    

    // better reference
    // https://twitter.com/web3_dev0/status/1483355410623078404

    // Mappings in Solidity lets learn this via an example
    // cart variable
    // username => [productId] # here username is key and array of productId is value
    // cart_abbas =>  [0]
    // cart_jain =>  [2,1]
    // cart_yash =>  [3,2]
    // {key:value}
    // SYNTEX
    // mapping(key_data_type => value_data_type) nameOfVariable 
    mapping(address => uint[]) public cart;

    // mappings to keep record of payments
    mapping(address => uint) public payments;


    function addProduct  (string memory _description,
        string memory _imageURl,
        string memory _author,
        string memory _title,
        uint _price
        ) public {   
        // public => any one call this fuction like any other Smart Contract, external call 

        /* 
            memory => is used for tempory holding your data similar to computer RAM, it saves GAS Fee. We have to use memeory keyword with every data type 
            using locally except with interger 
        */

    
        Product memory tempProduct = Product({
            description:_description,
            imageURl:_imageURl,
            author:_author,
            title:_title,
            price:_price,
            id:ID // ID is global variable
        });  // object of type Product

        products.push(tempProduct); // add item to array 
        ID = ID+1; // increment an ID 
    
    } // addProducts Ends

    // add item to cart

    function addItemToCart(uint _productId) public {
        // cart[key] = value;
        // msg.sender => it gives the address of caller
        // hash table // dictnory
        // {key:value}
        // key : unique
        // value : any datatype 
        // sting // string[]

        // cart
        // address of your metmask
        // address:[productId1,productId2,....]

        // mapping(address => uint[]) cart;
        // cart[key] = values
        // cart[abbash_address].push(0)
        // cart[abbash_address].push(1)
        // cart[abbash_address].push(10)
        // address_abbash => [0,1,10]
        cart[msg.sender].push(_productId);
    }
    // view => using a state variable within a fuction but you are changing its value
    function getItemFromCart() public view returns (uint[] memory){
        return cart[msg.sender]; 
    }


    // calculate total of a user's cart
    function checkout() public view returns(uint)  {
        uint cartTotal;
        uint[] memory cartItems = getItemFromCart();
        // getItemFromCart function return array of productIds 

        // how loops works in Solidity
        for(uint i=0; i< cartItems.length;i++){ 
            // cart.caller_address.i => array items 
            uint productId = cartItems[i];
            uint price = products[productId].price; 
            cartTotal = cartTotal + price;
        }
        return cartTotal;
    }
    
    // use to recieve payments into our smart contract. payables is used to recieve funds into your smart contract account remember this
    
    function pay() public payable {
        payments[msg.sender] += msg.value;
    }


} // contract ends here 



/* 
Question 
Q: why we use memory string solidity
Q: is it possible to return array from inbuilt variable we define
Q: floating point
*/