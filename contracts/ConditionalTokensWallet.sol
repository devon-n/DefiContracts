pragma solidity ^0.5.0;

import './ERC20.sol';
import './IERC20.sol';
import './IConditionalTokans.sol';


contract ConditionalTokensWallet is IERC1155TokenReceiver {
        IERC20 dai;
    IConditionalTokens conditionalTokens;
    address public oracle;
    mapping(bytes32 => mapping(uint => uint)) public tokenBalance;
    address admin;

    constructor(
        address _dai,
        address _conditionalTokens,
        address _oracle
    ) public {
        dai = IERC20(_dai);
        conditionalTokens = IConditionalTokens(_conditionalTokens);
        oracle = oracle;
        admin = msg.sender
    }

    function redeemTokens(
        bytes32 conditionId,
        uint[] calldata indexSets
    ) external {
        conditionalTokens.redeemPositions(
            dai,
            bytes32(0),
            conditionId,
            indexSets
        );
    }

    function transferDai(
        address to,
        uint amount
    ) external {
        require(msg.sender == admin, 'Only Admin');
        dai.transfer(to, amount);
    }


    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    )   external
        returns (bytes4) {
            return bytes4(keccak function)
    }
    
    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    )   external
        returns (bytes4) {
            return bytes4(keccak function)
    }

}