pragma solidity ^0.5.0;

import 'https://github.com/aave/aave-protocol/blob/master/contracts/configuration/LendingPoolAddressesProvider.sol';
import 'https://github.com/aave/aave-protocol/blob/master/contracts/lendingpool/LendingPool.sol';
import 'https://github.com/aave/aave-protocol/blob/master/contracts/flashloan/base/FlashLoanReceiverBase.sol';

contract AaveFlashLoan is FlashLoanReceiverBase {
    // Initiate Dai and Lending Pool Provider
    LendingPoolAddressesProvider provider;
    address dai;

    constructor(
        address _provider, 
        address _dai) 
        FlashLoanReceiverBase(_provider)
        public {
        provider = LendingPoolAddressesProvider(_provider);
        dai = _dai;
    }

    function startLoan(uint amount, bytes calldata _params) external {
        // Create instance of lending pool
        lendingPool lendingPool = LendingPool(provider.getLendingPool());
        // Start flash loan
        lendingPool.flashloan(address(this), dai, amount, _params);
    }

    function executeOperation(
        address _reserve,
        uint _amount,
        uint _fee,
        bytes memory _params
    ) external {
        // arbitrage, refinance
        // repay
        transferFundsBackToPoolInternal(_reserve, amount + fee);
    }
    
}