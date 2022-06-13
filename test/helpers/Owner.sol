// SPDX-License-Identifier: GNU AGPLv3
pragma solidity ^0.8.13;

import "src/MorphoToken.sol";

contract Owner {
    MorphoToken token;

    function setToken(MorphoToken _token) external {
        token = _token;
    }

    /// ERC20 CONTROL FUNCTIONS ///

    function mint(address to, uint amount) external {
        token.mint(to, amount);
    }

    function mint(uint amount) external {
        token.mint(address(this), amount);
    }

    function approve(address spender) external {
        token.approve(spender, type(uint256).max);
    }

    function transfer(address to, uint256 amount) external {
        token.transfer(to, amount);
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external {
        token.transferFrom(from, to, amount);
    }

    /// RolesAuthority CONTROL FUNCTIONS ///

    // Target omitted from arguments since it's always the token.
    function setRoleCapability(
        uint8 role,
        bytes4 functionSig,
        bool enabled
    ) external {
        token.setRoleCapability(role, address(token), functionSig, enabled);
    }

    function setUserRole(
        address user,
        uint8 role,
        bool enabled
    ) external {
        token.setUserRole(user, role, enabled);
    }

    // Target omitted from arguments since it's always the token.
    function setPublicCapability(bytes4 functionSig, bool enabled) external {
        token.setPublicCapability(address(token), functionSig, enabled);
    }

    function disown() external {
        token.setOwner(address(0));
    }
}
