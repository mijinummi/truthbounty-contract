// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../storage/VoterRegistry.sol";

contract VotingClaims {

    using VoterRegistry for address;

    mapping(bytes32 => bool)
        public processedClaims;

    event ClaimProcessed(
        address indexed voter,
        bytes32 indexed claimId
    );

    function processClaim(
        bytes32 claimId
    ) external {

        require(
            !processedClaims[claimId],
            "Claim already processed"
        );

        processedClaims[claimId] = true;

        // Reuse voter slot instead
        VoterRegistry.initializeVoter(
            msg.sender
        );

        VoterRegistry.incrementClaims(
            msg.sender
        );

        emit ClaimProcessed(
            msg.sender,
            claimId
        );
    }

    function getClaimCount(
        address voter
    ) external view returns (uint256) {

        return
            VoterRegistry.totalClaims(voter);
    }
}