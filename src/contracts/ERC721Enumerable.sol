// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is ERC721, IERC721Enumerable {
    uint256[] private _allTokens;

    mapping(uint256 => uint256) private _allTokensIndex;
    mapping(address => uint256[]) private _ownedTokens;
    mapping(uint256 => uint256) private _ownedTokensIndex;

    constructor() {
     registerInterface( bytes4( keccak256( "tokenByIndex(bytes4)") ^ keccak256( "tokenOfOwnerByIndex(bytes4)") ^ keccak256( "totalSupply(bytes4)") ) );
    }


    function tokenByIndex(uint256 _index) external override view returns (uint256) {
        require(_index < totalSupply(), "Global index is out of bounds");
        return _allTokens[_index];
    }

    function tokenOfOwnerByIndex(address _owner, uint256 _index) external override view returns (uint256){
        require( _index < balanceOf( _owner ), "Owner index is out of bounds" );
        return _ownedTokens[_owner][_index];
    }

    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    function totalSupply() public view override returns (uint256) {
        return _allTokens.length;
    }
}
