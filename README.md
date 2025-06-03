# gNGN Token and Multi-Signature Wallet Contracts

This repository contains two main smart contracts:
1. **gNGN.sol**: A regulated stablecoin (G-Naira) implementation with blacklisting capabilities
2. **MultiSigWallet.sol**: A multi-signature wallet for secure contract administration

## Contracts Overview

### gNGN Token (G-Naira)
An ERC-20 compliant token with additional features:
- Minting and burning restricted to GOVERNOR_ROLE
- Address blacklisting functionality
- Access control via OpenZeppelin's AccessControl
- Built-in checks to prevent blacklisted addresses from sending/receiving tokens

### Multi-Signature Wallet
A secure wallet that requires multiple confirmations for transactions:
- Configurable number of owners and required confirmations
- Transaction submission, confirmation, and execution workflow
- Protection against duplicate confirmations and re-execution
- Event logging for all operations

## Deployment Details

Both contracts have been deployed and verified on the blockchain.

Below are there relevant links to block explorers;

Successfully submitted source code for contract
contracts/MultiSigWallet.sol:MultiSigWallet at 0x335Bd1baB32952146E2E603eE2410e5bAFf78549
for verification on the block explorer. Waiting for verification result...

Successfully verified contract MultiSigWallet on the block explorer.
https://sepolia.etherscan.io/address/0x335Bd1baB32952146E2E603eE2410e5bAFf78549#code

Successfully submitted source code for contract
contracts/GNGN.sol:GNGN at 0xDe776656F47E1914F5EE129fbaC88ADc4932b9be
for verification on the block explorer. Waiting for verification result...

Successfully verified contract GNGN on the block explorer.
https://sepolia.etherscan.io/address/0xDe776656F47E1914F5EE129fbaC88ADc4932b9be#code

### gNGN Token Constructor Parameters
- `multiSigWallet`: Address of the multi-sig wallet that will have ADMIN and GOVERNOR roles

### MultiSigWallet Constructor Parameters
- `_owners`: Array of owner addresses
- `_numConfirmationsRequired`: Number of confirmations required to execute transactions

## Usage

### gNGN Token Functions
- `mint(to, amount)`: Create new tokens (GOVERNOR_ROLE only)
- `burn(from, amount)`: Destroy tokens (GOVERNOR_ROLE only)
- `blacklist(account)`: Add address to blacklist
- `unblacklist(account)`: Remove address from blacklist

### Multi-Signature Wallet Workflow
1. **Submit Transaction**: Any owner can submit a transaction
2. **Confirm Transaction**: Owners confirm the transaction
3. **Execute Transaction**: When enough confirmations are gathered, any owner can execute

## Security Features

### gNGN Token
- Blacklisted addresses cannot send or receive tokens
- All privileged functions are role-protected
- Input validation for all parameters

### Multi-Signature Wallet
- Protection against invalid owners during construction
- Guards against duplicate confirmations
- Prevents re-execution of transactions
- Events for all state changes

## Events

### gNGN Token
- `Blacklisted(account, isBlacklisted)`: Emitted when an account's blacklist status changes

### Multi-Signature Wallet
- `Deposit(sender, amount)`: Emitted on ETH deposits
- `SubmitTransaction(owner, txIndex, to, value, data)`: New transaction submitted
- `ConfirmTransaction(owner, txIndex)`: Transaction confirmation
- `RevokeConfirmation(owner, txIndex)`: Confirmation revoked
- `ExecuteTransaction(owner, txIndex)`: Transaction executed

## Requirements
- Solidity ^0.8.20
- OpenZeppelin Contracts (for gNGN)

## License
MIT
