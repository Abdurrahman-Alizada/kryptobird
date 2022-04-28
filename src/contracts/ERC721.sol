// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _OwnedTokenCount;

    function _exist(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId]; //fetch owner from the mapping
        return owner != address(0); // check if owner exist and true or false
    }

    function balanceOf( address _owner ) public view returns(uint256) {
      require(_owner != address(0), "Empty owner qurey for non-existing NFT");
      return _OwnedTokenCount[_owner];
    }

    function ownerOf( uint256 _tokenId ) public view returns(address) {
        address owner = _tokenOwner[_tokenId]; 
        require( owner != address(0), "Empty owner query for non-existing NFT");
        return owner;
    }

    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: Minting to the zero address");
        require(!_exist(tokenId), "ERC721: Already minted");
        _tokenOwner[tokenId] = to;
        _OwnedTokenCount[to] += 1;
        emit Transfer(address(0), to, tokenId);
    }
}
