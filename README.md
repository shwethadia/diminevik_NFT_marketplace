# DimineVik NFT VIKY Marketplace

## Technology Stack & Tools

- Solidity (Writing Smart Contract)
- Javascript (React & Testing)
- [Ethers](https://docs.ethers.io/v5/) (Blockchain Interaction)
- [Hardhat](https://hardhat.org/) (Development Framework)
- [Ipfs](https://ipfs.io/) (Metadata storage)
- [React routers](https://v5.reactrouter.com/) (Navigational components)

## Requirements For Initial Setup
- Install [NodeJS](https://nodejs.org/en/), should work with any node version between 16.14.0 and 17.0.1
- Install [Hardhat](https://hardhat.org/)
- Install [Metamask](https://metamask.io/)

## Setting Up
### 1. Clone/Download the Repository

### 2. Install Dependencies:
```
$ cd nft_marketplace
$ npm install
```
### 3. Boot up local development blockchain
```
$ cd nft_marketplace
$ npx hardhat node
```

### 4. Migrate Smart Contracts
`npx hardhat run src/backend/scripts/deploy.js --network localhost`

### 5. Run Tests
`$ npx hardhat test`

### 6. Launch Frontend
`$ npm run start`

License
----
MIT

