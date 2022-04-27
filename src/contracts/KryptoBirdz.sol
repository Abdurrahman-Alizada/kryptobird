// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721connector.sol';

contract KryptoBird is ERC721Connector {
    
    constructor() ERC721Connector('KryptoBird', 'KBIRDS'){
        
    }

}
