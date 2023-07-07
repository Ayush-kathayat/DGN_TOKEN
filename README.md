# Degen Gaming Token

This Solidity program is a smart contract that implements an ERC20 token called "Degen" (DGN) for Degen Gaming. The contract allows for the creation of new tokens, token transfers, token redemption for in-game items, checking token balances, and burning tokens that are no longer needed.

## Functionality

The Degen Gaming Token contract provides the following functionality:

1. **Minting new tokens:** The contract owner can mint new tokens and distribute them to players as rewards.

2. **Transferring tokens:** Players can transfer their tokens to others.

3. **Redeeming tokens:** Players can redeem their tokens for items in the in-game store. The available items and their costs are as follows:
   - NFTs: 5000 DGN
   - Shirts: 400 DGN
   - Shoes: 1500 DGN

4. **Checking token balance:** Players can check their token balance at any time.

5. **Burning tokens:** Anyone can burn tokens they own, which are no longer needed.

## Deployment

To deploy the Degen Gaming Token contract on the Avalanche network's Fuji Testnet, follow these steps:

1. Make sure you have a compatible development environment set up, such as Hardhat.

```
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

```
2. Copy and paste the provided code into a new Solidity file (e.g., `DegenToken.sol`).

3. In the contract constructor, modify the token name and symbol as desired.

4. Compile the contract using your development environment.

5. Configure your development environment to connect to the Avalanche network's Fuji Testnet. Refer to the documentation or tutorials provided by your development environment for instructions on how to configure the network.

6. Deploy the contract using your development environment, specifying the account that will be the owner of the contract.

7. Take note of the deployed contract address, as it will be needed for interacting with the contract.

## Interacting with the Contract

Once the Degen Gaming Token contract is deployed, players can interact with it using various methods. Here are some examples:

### Minting New Tokens

Only the contract owner can mint new tokens. To mint tokens for a specific player, call the `mint` function, specifying the player's address and the amount of tokens to mint.

### Transferring Tokens

Players can transfer their tokens to others by calling the `transfer` function, specifying the recipient's address and the amount of tokens to transfer.

### Redeeming Tokens

To redeem tokens for in-game items, players should follow these steps:

1. Call the `Show_item` function to view the available items and their costs.

2. Choose an item number (1 for NFTs, 2 for Shirts, 3 for Shoes) and call the `choose_item` function, passing the chosen item number as an argument.

### Checking Token Balance

Players can check their token balance by calling the `balanceOf` function, passing their address as an argument.

### Burning Tokens

To burn tokens that are no longer needed, call the `burn` function, specifying the amount of tokens to burn.

Video Explanation
To get a detailed explanation of the code and see its output, please watch the [Degen Gaming Token Demo Video](https://www.loom.com/share/d471dab85aa045adb0e3b0513eda22a3?sid=31386271-24bc-4c88-80ce-a8003264f8bc) where I provide a step-by-step walkthrough.

## Authors

[Ayush Kathayat](https://github.com/Ayush-kathayat)

## License

This project is licensed under the MIT License. See the [LICENSE.md](https://license.md/) file for details.
