// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract GNGN is ERC20, AccessControl {
    bytes32 public constant GOVERNOR_ROLE = keccak256("GOVERNOR_ROLE");
    mapping(address => bool) public blacklisted;

    event Blacklisted(address indexed account, bool isBlacklisted);

    constructor(address multiSigWallet) ERC20("G-Naira", "gNGN") {
        require(multiSigWallet != address(0), "Invalid multi-sig wallet address");
        _grantRole(DEFAULT_ADMIN_ROLE, multiSigWallet);
        _grantRole(GOVERNOR_ROLE, multiSigWallet);
    }

    function mint(address to, uint256 amount) public onlyRole(GOVERNOR_ROLE) {
        require(to != address(0), "Mint to zero address");
        require(!blacklisted[to], "Recipient is blacklisted");
        require(amount > 0, "Amount must be greater than zero");
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyRole(GOVERNOR_ROLE) {
        require(from != address(0), "Burn from zero address");
        require(!blacklisted[from], "Sender is blacklisted");
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(from) >= amount, "Insufficient balance");
        _burn(from, amount);
    }

    function blacklist(address account) public onlyRole(GOVERNOR_ROLE) {
        require(account != address(0), "Cannot blacklist zero address");
        require(!blacklisted[account], "Account already blacklisted");
        blacklisted[account] = true;
        emit Blacklisted(account, true);
    }

    function unblacklist(address account) public onlyRole(GOVERNOR_ROLE) {
        require(account != address(0), "Cannot unblacklist zero address");
        require(blacklisted[account], "Account not blacklisted");
        blacklisted[account] = false;
        emit Blacklisted(account, false);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20) {
        // Skip checks for minting (from is zero) and burning (to is zero)
        if (from != address(0)) {
            require(!blacklisted[from], "Sender is blacklisted");
        }
        if (to != address(0)) {
            require(!blacklisted[to], "Recipient is blacklisted");
        }
        super._beforeTokenTransfer(from, to, amount);
    }
}