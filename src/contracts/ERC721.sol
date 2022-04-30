// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";

contract ERC721 is ERC165, IERC721 {
    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _OwnedTokenCount;
    mapping(address => uint256) private _tokenApprovals;

    constructor() {
        registerInterface( bytes4( keccak256( "balanceOf(bytes4)") ^ keccak256( "ownerOf(bytes4)") ^ keccak256( "transferFrom(bytes4)") ) );
    }

    function balanceOf(address _owner) public view override returns (uint256) {
        require(_owner != address(0), "Empty owner qurey for non-existing NFT");
        return _OwnedTokenCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view override returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "Empty owner query for non-existing NFT");
        return owner;
    }

    function _transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) internal {
        require(_to != address(0), "Transfer to the zero address");
        //  require( ownerOf(_tokenId) == _from, "Address does not exist" );
        _OwnedTokenCount[_from] -= 1;
        _OwnedTokenCount[_to] += 1;
        _tokenOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function _exist(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId]; //fetch owner from the mapping
        return owner != address(0); // check if owner exist and true or false
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public override {
        // require(isApprovedOrOwner(msg.sender, _tokenId), "error");
        _transferFrom(_from, _to, _tokenId);
    }

    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: Minting to the zero address");
        require(!_exist(tokenId), "ERC721: Already minted");
        _tokenOwner[tokenId] = to;
        _OwnedTokenCount[to] += 1;
        emit Transfer(address(0), to, tokenId);
    }
    // function approve( address _to, uint256 _tokenId ) public{
    //  address owner = ownerOf(_tokenId);
    //  require(_to != owner, "ERROR: Approval to current owner");
    //  require(msg.sender == owner, "Current caller is not the owner" );
    //  _tokenApprovals[ _tokenId ] = _to;
    //  emit Approval(owner, _to, _tokenId);
    // }
}
