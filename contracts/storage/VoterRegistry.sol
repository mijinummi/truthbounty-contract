// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library VoterRegistry {

    struct VoterData {
        bool initialized;
        uint256 totalClaims;
    }

    struct RegistryStorage {
        mapping(address => VoterData)
            voters;
    }

    bytes32 internal constant STORAGE_SLOT =
        keccak256("stellarwave.voter.registry");

    function layout()
        internal
        pure
        returns (RegistryStorage storage ds)
    {
        bytes32 slot = STORAGE_SLOT;

        assembly {
            ds.slot := slot
        }
    }

    function initializeVoter(
        address voter
    ) internal {

        RegistryStorage storage ds =
            layout();

        if (!ds.voters[voter].initialized) {
            ds.voters[voter].initialized =
                true;
        }
    }

    function incrementClaims(
        address voter
    ) internal {

        RegistryStorage storage ds =
            layout();

        ds.voters[voter]
            .totalClaims += 1;
    }

    function totalClaims(
        address voter
    ) internal view returns (uint256) {

        return
            layout()
                .voters[voter]
                .totalClaims;
    }
}