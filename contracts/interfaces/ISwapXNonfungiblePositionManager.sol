// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;
pragma abicoder v2;

/// @title Non-fungible token for positions
/// @notice Wraps Algebra positions in a non-fungible token interface which allows for them to be transferred
/// and authorized.
/// @dev Credit to Uniswap Labs under GPL-2.0-or-later license:
/// https://github.com/Uniswap/v3-periphery
interface ISwapXNonfungiblePositionManager {
    /// @notice Emitted when liquidity is increased for a position NFT
    /// @dev Also emitted when a token is minted
    /// @param tokenId The ID of the token for which liquidity was increased
    /// @param liquidityDesired The amount by which liquidity for the NFT position was increased
    /// @param actualLiquidity the actual liquidity that was added into a pool. Could differ from
    /// _liquidity_ when using FeeOnTransfer tokens
    /// @param amount0 The amount of token0 that was paid for the increase in liquidity
    /// @param amount1 The amount of token1 that was paid for the increase in liquidity
    event IncreaseLiquidity(
        uint256 indexed tokenId,
        uint128 liquidityDesired,
        uint128 actualLiquidity,
        uint256 amount0,
        uint256 amount1,
        address pool
    );

    /// @notice Emitted when liquidity is decreased for a position NFT
    /// @param tokenId The ID of the token for which liquidity was decreased
    /// @param liquidity The amount by which liquidity for the NFT position was decreased
    /// @param withdrawalFeeliquidity Withdrawal fee liq
    /// @param amount0 The amount of token0 that was accounted for the decrease in liquidity
    /// @param amount1 The amount of token1 that was accounted for the decrease in liquidity
    event DecreaseLiquidity(
        uint256 indexed tokenId, uint128 liquidity, uint128 withdrawalFeeliquidity, uint256 amount0, uint256 amount1
    );

    /// @notice Emitted when a fee vault is set for a pool
    /// @param pool The address of the pool to which the vault have been applied
    /// @param feeVault The address of the fee vault
    /// @param fee Percentage of withdrawal fee that will be sent to the vault
    event FeeVaultForPool(address pool, address feeVault, uint16 fee);

    /// @notice Emitted when tokens are collected for a position NFT
    /// @dev The amounts reported may not be exactly equivalent to the amounts transferred, due to rounding behavior
    /// @param tokenId The ID of the token for which underlying tokens were collected
    /// @param recipient The address of the account that received the collected tokens
    /// @param amount0 The amount of token0 owed to the position that was collected
    /// @param amount1 The amount of token1 owed to the position that was collected
    event Collect(uint256 indexed tokenId, address recipient, uint256 amount0, uint256 amount1);

    /// @notice Emitted if farming failed in call from NonfungiblePositionManager.
    /// @dev Should never be emitted
    /// @param tokenId The ID of corresponding token
    event FarmingFailed(uint256 indexed tokenId);

    /// @notice Emitted after farming center address change
    /// @param farmingCenterAddress The new address of connected farming center
    event FarmingCenter(address farmingCenterAddress);

    /// @notice Returns the position information associated with a given token ID.
    /// @dev Throws if the token ID is not valid.
    /// @param tokenId The ID of the token that represents the position
    /// @return nonce The nonce for permits
    /// @return operator The address that is approved for spending
    /// @return token0 The address of the token0 for a specific pool
    /// @return token1 The address of the token1 for a specific pool
    /// @return tickLower The lower end of the tick range for the position
    /// @return tickUpper The higher end of the tick range for the position
    /// @return liquidity The liquidity of the position
    /// @return feeGrowthInside0LastX128 The fee growth of token0 as of the last action on the individual position
    /// @return feeGrowthInside1LastX128 The fee growth of token1 as of the last action on the individual position
    /// @return tokensOwed0 The uncollected amount of token0 owed to the position as of the last computation
    /// @return tokensOwed1 The uncollected amount of token1 owed to the position as of the last computation
    function positions(uint256 tokenId)
        external
        view
        returns (
            uint88 nonce,
            address operator,
            address token0,
            address token1,
            int24 tickLower,
            int24 tickUpper,
            uint128 liquidity,
            uint256 feeGrowthInside0LastX128,
            uint256 feeGrowthInside1LastX128,
            uint128 tokensOwed0,
            uint128 tokensOwed1
        );

    struct MintParams {
        address token0;
        address token1;
        int24 tickLower;
        int24 tickUpper;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
        address recipient;
        uint256 deadline;
    }

    /// @notice Creates a new position wrapped in a NFT
    /// @dev Call this when the pool does exist and is initialized. Note that if the pool is created but not initialized
    /// a method does not exist, i.e. the pool is assumed to be initialized.
    /// @dev If native token is used as input, this function should be accompanied by a `refundNativeToken` in multicall to avoid potential loss of native tokens
    /// @param params The params necessary to mint a position, encoded as `MintParams` in calldata
    /// @return tokenId The ID of the token that represents the minted position
    /// @return liquidity The liquidity delta amount as a result of the increase
    /// @return amount0 The amount of token0
    /// @return amount1 The amount of token1
    function mint(MintParams calldata params)
        external
        payable
        returns (uint256 tokenId, uint128 liquidity, uint256 amount0, uint256 amount1);

    struct IncreaseLiquidityParams {
        uint256 tokenId;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
        uint256 deadline;
    }

    /// @notice Increases the amount of liquidity in a position, with tokens paid by the `msg.sender`
    /// @param params tokenId The ID of the token for which liquidity is being increased,
    /// amount0Desired The desired amount of token0 to be spent,
    /// amount1Desired The desired amount of token1 to be spent,
    /// amount0Min The minimum amount of token0 to spend, which serves as a slippage check,
    /// amount1Min The minimum amount of token1 to spend, which serves as a slippage check,
    /// deadline The time by which the transaction must be included to effect the change
    /// @dev If native token is used as input, this function should be accompanied by a `refundNativeToken` in multicall to avoid potential loss of native tokens
    /// @return liquidity The liquidity delta amount as a result of the increase
    /// @return amount0 The amount of token0 to achieve resulting liquidity
    /// @return amount1 The amount of token1 to achieve resulting liquidity
    function increaseLiquidity(IncreaseLiquidityParams calldata params)
        external
        payable
        returns (uint128 liquidity, uint256 amount0, uint256 amount1);

    struct DecreaseLiquidityParams {
        uint256 tokenId;
        uint128 liquidity;
        uint256 amount0Min;
        uint256 amount1Min;
        uint256 deadline;
    }

    /// @notice Decreases the amount of liquidity in a position and accounts it to the position
    /// @param params tokenId The ID of the token for which liquidity is being decreased,
    /// amount The amount by which liquidity will be decreased,
    /// amount0Min The minimum amount of token0 that should be accounted for the burned liquidity,
    /// amount1Min The minimum amount of token1 that should be accounted for the burned liquidity,
    /// deadline The time by which the transaction must be included to effect the change
    /// @return amount0 The amount of token0 accounted to the position's tokens owed
    /// @return amount1 The amount of token1 accounted to the position's tokens owed
    function decreaseLiquidity(DecreaseLiquidityParams calldata params)
        external
        payable
        returns (uint256 amount0, uint256 amount1);

    struct CollectParams {
        uint256 tokenId;
        address recipient;
        uint128 amount0Max;
        uint128 amount1Max;
    }

    /// @notice Collects up to a maximum amount of fees owed to a specific position to the recipient
    /// @param params tokenId The ID of the NFT for which tokens are being collected,
    /// recipient The account that should receive the tokens,
    /// amount0Max The maximum amount of token0 to collect,
    /// amount1Max The maximum amount of token1 to collect
    /// @return amount0 The amount of fees collected in token0
    /// @return amount1 The amount of fees collected in token1
    function collect(CollectParams calldata params) external payable returns (uint256 amount0, uint256 amount1);

    /// @notice Burns a token ID, which deletes it from the NFT contract. The token must have 0 liquidity and all tokens
    /// must be collected first.
    /// @param tokenId The ID of the token that is being burned
    function burn(uint256 tokenId) external payable;

    /// @notice Changes approval of token ID for farming.
    /// @param tokenId The ID of the token that is being approved / unapproved
    /// @param approve New status of approval
    /// @param farmingAddress The address of farming: used to prevent tx frontrun
    function approveForFarming(uint256 tokenId, bool approve, address farmingAddress) external payable;

    /// @notice Changes farming status of token to 'farmed' or 'not farmed'
    /// @dev can be called only by farmingCenter
    /// @param tokenId The ID of the token
    /// @param toActive The new status
    function switchFarmingStatus(uint256 tokenId, bool toActive) external;

    struct FeesVault {
        address feeVault;
        uint16 fee;
    }

    struct WithdrawalFeePoolParams {
        uint64 apr0;
        uint64 apr1;
        uint16 withdrawalFee;
        FeesVault[] feeVaults;
    }

    /// @notice Returns pending withdrawal fee liquidity
    /// @param tokenId Position ID
    /// @return pendingWithdrawalFeeLiquidity The pending withdrawal fee liquidity
    function calculatePendingWithdrawalFeesLiquidity(uint256 tokenId)
        external
        view
        returns (uint128 pendingWithdrawalFeeLiquidity);

    /// @notice Returns actual withdrawal fee liquidity of position
    /// @param tokenId Position ID
    /// @return latestWithdrawalFeeLiquidity The actual withdrawal fee liquidity
    function calculateLatestWithdrawalFeesLiquidity(uint256 tokenId)
        external
        view
        returns (uint128 latestWithdrawalFeeLiquidity);

    /// @notice Returns withdrawal fee params for pool
    /// @param pool Pool address
    /// @return params
    function getWithdrawalFeePoolParams(address pool) external view returns (WithdrawalFeePoolParams memory params);

    /// @notice Changes withdrawalFee for pool
    /// @dev can be called only by factory owner or NONFUNGIBLE_POSITION_MANAGER_ADMINISTRATOR_ROLE
    /// @param pool The address of the pool to which the settings have been applied
    /// @param newWithdrawalFee Percentage of lst token earnings that will be sent to the vault
    function setWithdrawalFee(address pool, uint16 newWithdrawalFee) external;

    /// @notice Changes tokens apr for pool
    /// @dev can be called only by factory owner or NONFUNGIBLE_POSITION_MANAGER_ADMINISTRATOR_ROLE
    /// @param pool The address of the pool to which the settings have been applied
    /// @param apr0 APR of LST token0
    /// @param apr1 APR of LST token1
    function setTokenAPR(address pool, uint64 apr0, uint64 apr1) external;

    /// @notice Changes fee vault for pool
    /// @dev can be called only by factory owner or NONFUNGIBLE_POSITION_MANAGER_ADMINISTRATOR_ROLE
    /// @param pool The address of the pool to which the settings have been applied
    /// @param fees array of fees values
    /// @param vaults array of vault addresses
    function setVaultsForPool(address pool, uint16[] memory fees, address[] memory vaults) external;

    /// @notice Returns vault address to which fees will be sent
    /// @return vault The actual vault address
    function defaultWithdrawalFeesVault() external view returns (address vault);

    /// @notice Changes vault address
    /// @dev can be called only by factory owner or NONFUNGIBLE_POSITION_MANAGER_ADMINISTRATOR_ROLE
    /// @param newVault The new address of vault
    function setVaultAddress(address newVault) external;

    /// @notice Returns withdrawalFee information associated with a given token ID
    /// @param tokenId The ID of the token that represents the position
    /// @return lastUpdateTimestamp Last increase/decrease liquidity timestamp
    /// @return withdrawalFeeLiquidity Liqudity of accumulated withdrawal fee
    function positionsWithdrawalFee(uint256 tokenId)
        external
        view
        returns (uint32 lastUpdateTimestamp, uint128 withdrawalFeeLiquidity);

    /// @notice Changes address of farmingCenter
    /// @dev can be called only by factory owner or NONFUNGIBLE_POSITION_MANAGER_ADMINISTRATOR_ROLE
    /// @param newFarmingCenter The new address of farmingCenter
    function setFarmingCenter(address newFarmingCenter) external;

    /// @notice Returns whether `spender` is allowed to manage `tokenId`
    /// @dev Requirement: `tokenId` must exist
    function isApprovedOrOwner(address spender, uint256 tokenId) external view returns (bool);

    /// @notice Returns the address of currently connected farming, if any
    /// @return The address of the farming center contract, which handles farmings logic
    function farmingCenter() external view returns (address);

    /// @notice Returns the address of farming that is approved for this token, if any
    function farmingApprovals(uint256 tokenId) external view returns (address);

    /// @notice Returns the address of farming in which this token is farmed, if any
    function tokenFarmedIn(uint256 tokenId) external view returns (address);
}
