pragma solidity ^0.8.0;

import './ERC20.sol';
import './IERC20.sol';
import './IConditionalTokans.sol';


contract Gnosis {
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

    function createBet(bytes32 questionId, uint amount) external {
        conditionalTokens.prepareCondition(
            oracle,
            questionId,
            3
        );

        bytes32 conditionId = conditionalTokens.getConidtionId(
            oracle,
            questionId,
            3
        );

        dai.approve(address(conditionalTokens), amount);

        /* 
        Partition is an array of a bitmap vector for the possible outcomes
        A = 001
        B = 010
        C = 100
        B|C = 110 because you add the two outcomes together        
        A|B = 011

        Lets build outcomes A and B|C
        */

        uint[] memory partition = new uint[](2);
        partition[0] = 1;
        partition[1] = 3;
        conditionalTokens.splitPosition(
            dai,
            bytes32(0),
            conditionId,
            partition,
            amount
        );

        tokenBalance[questionId][0] = amount;
        tokenBalance[questionId][1] = amount;
    }

    function transferTokens(
        bytes32 questionId,
        uint indexSet,
        address to,
        uint amount
    ) external {
        require(msg.sender == admin, 'Only Admin');
        require(tokenBalance[questionId][indexSet] >= amount, 'Insufficient funds');

        bytes32 conditionId = conditionalTokens.getConditionId(
            oracle,
            question,
            3
        );

        bytes32 collectionId = conditionalTokens.getCollectionId(
            bytes32(0),
            conditionId,
            indexSet
        );
        
        uint positionId = conditionalTokens.getPositionId(
            dai,
            collectionId
        );

        conditionalTokens.safeTransferFrom(
            address(this),
            to,
            positionId,
            amount,
            ""
        );
    }

    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    )
        external
        returns (bytes4) {
            return bytes4(keccak function)
    }
    
    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    )
        external
        returns (bytes4) {
            return bytes4(keccak function)
    }



}