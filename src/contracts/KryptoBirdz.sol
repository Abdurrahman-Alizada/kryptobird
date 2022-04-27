// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721connector.sol';

contract KryptoBird is ERC721Connector {
    
    string[] public kryptobirds;
    
    mapping(string => bool) _kryptoBirdsExists;

    function mint(string memory _kryptobird) public{
     
     require( !_kryptoBirdsExists[_kryptobird], "Error : Kryptobird already exist");

     kryptobirds.push(_kryptobird);
     uint _id = kryptobirds.length - 1;
     _mint(msg.sender, _id);
    _kryptoBirdsExists[_kryptobird] = true;
    }
    constructor() ERC721Connector('KryptoBird', 'KBIRDS'){
        
    }

}
