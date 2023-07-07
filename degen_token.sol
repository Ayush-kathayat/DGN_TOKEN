// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";

contract Degen_Token is ERC20 {

    address private _owner;

    address public Owner_Minter = 0x1CBd3b2770909D4e10f157cABC84C7264073C9Ec;

    constructor() ERC20("Degen", "DGN") {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(
            msg.sender == _owner,
            "Only the contract owner can call this function"
        );
        _;
    }

    function mint(address account, uint256 amount) external payable onlyOwner {
        _mint(account, amount);
    }

    function transfer(address recipient, uint256 amount)
        public
        override
        returns (bool)
    {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // HERE BELOW IS ALL ABOUT THE REDEEMING

    function Show_item() public view {
        console.log("Item : Cost");
        console.log("1 => NFTs : 5000");
        console.log("2 => Shirts : 400");
        console.log("3 => Shoes : 1500");
    }

    function choose_item(uint256 item_num) external payable {
        redeem(item_num);
    }

    function redeem(uint256 item_num) public payable {
        require(item_num >= 1 && item_num <= 3, "Invalid item number");

        if (item_num == 1) {
            require(
                balanceOf(msg.sender) >= 5000,
                "Insufficient balance for NFTs"
            );
            _transfer(msg.sender , Owner_Minter, 5000);
            console.log("One");
        } else if (item_num == 2) {
            require(
                balanceOf(msg.sender) >= 400,
                "Insufficient balance for Shirts"
            );
            _transfer(msg.sender , Owner_Minter, 400);

            console.log("Second");
        } else if (item_num == 3) {
            require(
                balanceOf(msg.sender) >= 1500,
                "Insufficient balance for Shoes"
            );
            
            _transfer(msg.sender , Owner_Minter, 1500);

            console.log("Three");
        }
    }
}
