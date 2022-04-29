// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );
    
    event approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );

    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _OwnedTokenCount;
    mapping(address => uint256) private _tokenApprovals;
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

    function approve( address _to, uint256 _tokenId ) public{
     address owner = ownerOf(_tokenId);
     require(_to != owner, "ERROR: Approval to current owner");
     require(msg.sender == owner, "Current caller is not the owner" );
     _tokenApprovals[ _tokenId ] = to;
     emit Approval(owner, _to, _tokenId); 
    }
}
