// SPDX-License-Identifier: GNU AGPLv3
pragma solidity ^0.8.13;

import "src/MorphoToken.sol";
import "./helpers/Owner.sol";
import "forge-std/Test.sol";
import "forge-std/console2.sol";

/// @dev Simple test suite for Morpho token scenarios.
/// @dev For in depth tests, directly check Solmate and Semitransferable Token repositories.
contract TestMorphoToken is Test {
    MorphoToken public morphoToken;

    uint256 public constant TOTAL_SUPPLY = 1e9 ether;
    uint256 public constant AMOUNT = 1e3 ether;
    uint8 public constant TRANSFER_ROLE = 0;
    uint8 public constant MINT_ROLE = 1;

    Owner public owner;
    address $owner;
    address $this;

    function setUp() public {
        owner = new Owner();
        $owner = address(owner);
        $this = address(this);

        morphoToken = new MorphoToken($owner);

        owner.setToken(morphoToken);

        // Set every roles to owner.
        owner.setRoleCapability(TRANSFER_ROLE, Token.transfer.selector, true);
        owner.setRoleCapability(
            TRANSFER_ROLE,
            Token.transferFrom.selector,
            true
        );
        owner.setRoleCapability(MINT_ROLE, Token.mint.selector, true);
    }

    function testDeployment() public {
        assertEq(morphoToken.totalSupply(), TOTAL_SUPPLY);
        assertEq(morphoToken.owner(), $owner);
    }

    // At any stage, holders can burn their own tokens.
    function testBurnTokens(uint256 _amount) public {
        vm.assume(_amount <= TOTAL_SUPPLY);
        owner.transfer($this, _amount);

        morphoToken.burn(_amount / 2);
        assertEq(morphoToken.balanceOf($this), _amount / 2 + (_amount % 2));
    }

    // At stage 1, morpho token will ne be non transferable.
    function testNonTransferable(uint256 _amount) public {
        vm.assume(_amount <= TOTAL_SUPPLY);
        // vm.assume(_amount > 1);
        owner.transfer($this, _amount);

        vm.expectRevert("UNAUTHORIZED");
        morphoToken.transfer($owner, _amount);

        morphoToken.approve(address(0), type(uint256).max);
        vm.prank(address(0));
        vm.expectRevert("UNAUTHORIZED");
        morphoToken.transferFrom($this, address(0), _amount);
    }

    // At stage 2, only some contracts will be allowed to transfer tokens (eg. IncentivesVault, RewardsDistributor, etc.).
    function testWhitelisting(uint256 _amount) public {
        vm.assume(_amount <= TOTAL_SUPPLY);
        owner.transfer($this, _amount);

        // Set transfer & transferFrom roles to this contract.
        owner.setUserRole($this, TRANSFER_ROLE, true);

        assertTrue(morphoToken.transfer($owner, _amount / 2));

        morphoToken.approve($owner, type(uint256).max);
        owner.transferFrom($this, $owner, _amount / 2);
        assertEq(morphoToken.balanceOf($owner), TOTAL_SUPPLY - (_amount % 2));
    }

    // At stage 3 (final step), the morpho token will be fully transferable.
    function testFullyTransferable(uint256 _amount) public {
        vm.assume(_amount <= TOTAL_SUPPLY);
        owner.transfer($this, _amount);

        // Allow everyone to transfer & transferFrom.
        owner.setPublicCapability(Token.transfer.selector, true);
        owner.setPublicCapability(Token.transferFrom.selector, true);

        assertTrue(morphoToken.transfer($owner, _amount / 2));

        morphoToken.approve(address(0), type(uint256).max);
        vm.prank(address(0));
        morphoToken.transferFrom($this, $owner, _amount / 2);
        assertEq(morphoToken.balanceOf($owner), TOTAL_SUPPLY - (_amount % 2));
    }

    // Perhaps at last stage, the owner is removed.
    function testRemoveOwner(uint256 _amount) public {
        vm.assume(_amount <= TOTAL_SUPPLY);

        owner.disown();
        vm.expectRevert("UNAUTHORIZED");
        owner.mint($this, _amount);
    }
}
