// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;


import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";


contract Marketplace is ReentrancyGuard {


    address payable public immutable feeAccount;
    uint public immutable feePercent;
    uint public itemCount;


    struct Item {

        uint itemId;
        IERC721 nft;
        uint tokenId;
        uint price;
        address payable seller;
        bool sold;
    }

    event Offered(
        uint256 itemId,
        address indexed nft,
        uint256 tokenId,
        uint256 price,
        address indexed seller
    );

    event Bought(
        uint256 itemId,
        address indexed nft,
        uint256 tokenId,
        uint256 price,
        address indexed seller,
        address indexed buyer
    );


   //ItemId => Item

   mapping(uint => Item) public items;



    constructor (uint _feePercent){

        feeAccount = payable(msg.sender);
        feePercent = _feePercent;

    }

    function createItem(IERC721 _nft,uint _tokenId,uint _price) external nonReentrant {

        require(_price > 0,"Price must be greater than zero");
        itemCount ++;
        _nft.transferFrom(msg.sender, address(this), _tokenId);

        items[itemCount] = Item (

            itemCount,
            _nft,
            _tokenId,
            _price,
            payable(msg.sender),
            false
        );



        emit Offered (

            itemCount,
            address(_nft),
            _tokenId,
            _price,
            msg.sender
        );


    }


    function purchaseItem(uint _itemId) external payable nonReentrant{

        uint _totalPrice = getTotalPrice(_itemId);
        Item storage item = items[_itemId];
        require(_itemId > 0 && _itemId <= itemCount, "item doesn't exist");
        require(msg.value >= _totalPrice, "not enough ether to cover item price and market fee");
        require(!item.sold, "item already sold");

        item.seller.transfer(item.price);
        feeAccount.transfer(_totalPrice-item.price);
        item.sold = true;

        // transfer nft to buyer
        item.nft.transferFrom(address(this), msg.sender, item.tokenId);

        emit Bought(
            _itemId,
            address(item.nft),
            item.tokenId,
            item.price,
            item.seller,
            msg.sender
        );
    }

    
    function getTotalPrice(uint _itemId) view public returns(uint) {

        return ((items[_itemId].price*(100+feePercent))/100);
    }



}