// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract NFT is ERC721Enumerable, Ownable {
    //int => string
    using Strings for uint256;
    uint256 maxSupply = 25; //max amount of NFT
    uint256 cost = 0.001 ether; //ether == TBNB
    string baseURI = "ipfs://QmbBftcRb3j1GNMLx2wS9A4ncn4v5SQRGNbigDFkUD7Bp4/"; //IPFS - storage for NFT
    //other ways: server, onchain

    //Our NFT collection
    constructor() ERC721("KomodBabushki", "KB") {} 

    //functions ERC721
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory){
        _requireMinted(tokenId);
        return 
            bytes(baseURI).length > 0 
                ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) //combine strings .encodedPacked
                : "";
    }

    function changeBuseURI(string memory _newBaseURI) public onlyOwner{
            baseURI = _newBaseURI;
    }

    //Download NFT
    function safeMint(address _to) public payable{ //внешняя функция вызывает внутрению
       uint256 _currentSupply = totalSupply(); //How tokens now 
        require(_currentSupply < maxSupply, "You reached max supply");
        require(msg.value == cost, "Please add valid amount in TBNB");
        _safeMint(_to, _currentSupply);
    }

    function withdraw() public onlyOwner{
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success);
    }
}