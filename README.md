
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SubscriptionDAO {
    struct Creator {
        address wallet;
        uint256 totalEarnings;
    }

    address[] public creatorList;
    mapping(address => uint256) public creatorEarnings;

    // Add this function
    function getTopCreators(uint256 count) external view returns (address[] memory topCreators, uint256[] memory earnings) {
        require(count > 0, "Count must be greater than zero");
        uint256 total = creatorList.length < count ? creatorList.length : count;

        // Temporary array for sorting
        address[] memory sortedCreators = new address[](creatorList.length);
        for (uint i = 0; i < creatorList.length; i++) {
            sortedCreators[i] = creatorList[i];
        }

        // Sort creators by earnings (bubble sort for simplicity)
        for (uint i = 0; i < total; i++) {
            for (uint j = i + 1; j < creatorList.length; j++) {
                if (creatorEarnings[sortedCreators[j]] > creatorEarnings[sortedCreators[i]]) {
                    address temp = sortedCreators[i];
                    sortedCreators[i] = sortedCreators[j];
                    sortedCreators[j] = temp;
                }
            }
        }

        // Fill result arrays
        topCreators = new address[](total);
        earnings = new uint256[](total);
        for (uint i = 0; i < total; i++) {
            topCreators[i] = sortedCreators[i];
            earnings[i] = creatorEarnings[sortedCreators[i]];
        }
    }
}

"Updated.."