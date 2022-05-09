// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract TransferWithDai {

    IERC20 dai;

    constructor (address daiAddress) {
        // store address
        dai = IERC20(daiAddress);
    }

    function foo(address recipient, uint256 amount) external {
        
        dai.transfer(recipient, amount);
    }
}