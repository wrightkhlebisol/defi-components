// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ERC721OpenZeppelin1 is ERC721{
  constructor() ERC721("Token Name", "TokenSYM"){}
}

contract ERC721OpenZeppelin2 is ERC721{
  constructor() ERC721("Token Name", "TokenSYM"){
    _safeMint(msg.sender, 0);
  }
}

contract ERC721OpenZeppelin3 is ERC721{
  address public admin;

  constructor() ERC721("Token Name", "TokenSYM"){
    admin = msg.sender;
  }

  function mint(address to, uint tokenId) external {
    require(msg.sender == admin, 'only admin');
    _safeMint(to, tokenId);
  }
}

// contract ERC721OpenZeppelin3 is ERC721{
//   constructor() ERC721("Token Name", "TokenSYM"){}

//   function faucet(address to, uint tokenId) external {
//     _safeMint(to, tokenId);
//   }
// }
