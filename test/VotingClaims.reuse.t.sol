// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

import "../voting/VotingClaims.sol";

contract VotingClaimsReuseTest is Test {

    VotingClaims claims;

    function setUp() public {
        claims = new VotingClaims();
    }

    function testProcessesClaim()
        public
    {
        claims.processClaim(
            keccak256("claim-1")
        );

        assertEq(
            claims.getClaimCount(
                address(this)
            ),
            1
        );
    }

    function testReusesVoterStorage()
        public
    {
        claims.processClaim(
            keccak256("claim-1")
        );

        claims.processClaim(
            keccak256("claim-2")
        );

        claims.processClaim(
            keccak256("claim-3")
        );

        assertEq(
            claims.getClaimCount(
                address(this)
            ),
            3
        );
    }

    function testRejectsDuplicateClaim()
        public
    {
        bytes32 claimId =
            keccak256("claim-1");

        claims.processClaim(claimId);

        vm.expectRevert(
            "Claim already processed"
        );

        claims.processClaim(claimId);
    }
}