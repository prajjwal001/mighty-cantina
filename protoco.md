# Mission

The Mighty Finance team has a strong DeFi-focused background, constantly pushing the boundaries of early financial primitives. Now, we're channeling our collective expertise to drive meaningful change in the space.

## Our Mission

- **For Liquidity Providers**: Create a seamless environment for farming, hedging positions, and leveraging assets.
- **For Lenders**: Offer the most competitive APYs in the market.
- **User Experience First**: Deliver the best user experience.

# Introduction

Mighty Finance is a DeFi platform designed for concentrated liquidity market making (CLMM) with leveraged positions. It enables users to open leveraged positions, maximizing capital efficiency. Initially, we'll support highly liquid trading pairs, with plans to transition toward a more permissionless approach as we scale.

## Who is Mighty Finance For?

- **Lenders** – Earn rewards by supplying liquidity for leveraged trading.
- **Liquidity Providers** – Optimize capital efficiency with advanced liquidity management tools.

## Key Features

- **Concentrated Liquidity** – Provide liquidity within a specific price range to maximize capital efficiency. Currently, we support Shadow Exchange and are actively expanding to integrate additional protocols.
- **Leverage** – Amplify potential returns with up to 5x leverage, with plans to increase limits as total value locked (TVL) grows.
- **Lending** – Earn competitive yields by supplying tokens as leverage for liquidity providers.
- **Directional Bias & Hedging** – Liquidity providers can customize their exposure by choosing which tokens to borrow as leverage, allowing for more strategic positioning based on market conditions.

# Leverage Farming

## What is Leveraged Yield Farming?

Leveraged Farming is a core feature of Mighty Finance, enabling users to amplify returns by borrowing additional funds to invest in liquidity pools. By using existing assets as collateral, users can borrow stable or non-stable coins to purchase more tokens, increasing their exposure and potential profits.

Leverage Farming is one of the most effective ways to maximize capital efficiency. It requires no extra collateral, allowing users to fully benefit from leverage. Additionally, a well-planned Leverage Farming strategy can significantly reduce the impact of impermanent loss (IL).

## Example: How Leverage Farming Works

Let's illustrate this with an example:

1. User A has $1,000 in S and $1,000 in USDC.e
2. The user deposits these into the S/USDC.e liquidity pool on Shadow Exchange, earning a 640% APR.
3. While 640% is a decent return, User A wants higher yields.

## How Mighty Finance Helps

Instead of manual investment, User A turns to Mighty Finance for leveraged yield farming:

1. The user opens a 3x leverage position, borrowing an additional $2,000 in S and $2,000 in USDC.e
2. Factoring in a 5% borrowing rate, the user's new APR becomes: 3 * 640% − 2 * 5% = 1,910%

## Addressing Impermanent Loss (IL)

While leverage boosts returns, it also increases exposure to impermanent loss (IL). To manage this risk, User A adjusts borrowing strategy:

1. Instead of borrowing an equal amount of S and USDC.e, the user only borrows USDC ($4,000) while maintaining the 3x leverage.
2. This effectively creates a long position on S, benefiting from potential price appreciation when S price increases.

With this approach, User A:

- Mitigates IL risks in both price increases and declines.
- Optimizes returns across different market conditions.

Beyond this strategy, Mighty Finance will offer a range of customizable Leverage Farming strategies that adapt to various market scenarios.

## Why Choose Mighty Finance for Leverage Farming?

Mighty Finance makes leveraged yield farming accessible, efficient, and secure.

- **Up to 5x leverage** – Amplify returns while maintaining risk control.
- **Diverse liquidity pools** – Choose from various options to fit your strategy.
- **Customizable farming strategies** – Adjust leverage and borrowing combinations for different market conditions.

> **Note**: Leveraged farming involves risks, including exposure to volatile markets and borrowing costs. Users should conduct thorough research before investing. For the more details of the risks, please refer to the Risks page.

# Strategy (Long/Short)

Mighty Finance provides a range of leveraged farming strategies tailored to different market conditions. Whether you are bullish, bearish, or neutral, our strategies allow you to optimize yield, hedge risk, and enhance capital efficiency.

## Long Strategy

Used when you expect the price of a token to increase.

### How it Works:

1. Borrow stable token to pair with token A and provide liquidity in an A/Stable LP.
2. As the price of A rises, the LP position increases in value, generating additional yield.
3. At position closure, the borrowed amount remains the same, allowing for potential profit after repaying debt.

**Example**:  
A user believes S will rise relative to USDC.e. The user borrows USDC.e, open a leveraged S/USDC.e LP, and earn swap fee and LP reward while benefiting from S price appreciation.

## Short Strategy

Used when you expect the price of a token to decrease.

### How it Works:

1. Borrow token A instead of stable token to create a short exposure.
2. If A drops in price, the borrowed debt remains the same, and the position gains value.
3. At position closure, the debt is repaid at a discount, leading to profit.

**Example**:  
A user expects S to drop against USDC.e. The user borrows S, enter a leveraged S/USDC.e LP, and as S price declines, they repay the borrowed S at a lower price, generating returns.

## Choosing the Right Strategy

- **Bullish?** → Use the Long Strategy to maximize gains when S price rises.
- **Bearish?** → Use the Short Strategy to profit when S price drops.

Mighty Finance enables users to strategically optimize yield farming, manage risk, and maximize capital efficiency. Choose the right strategy based on your market outlook!

# Strategy (Pseudo Delta Neutral)

Pseudo-Delta-Neutral (PDN) Liquidity Provisioning is a strategy that enables users to provide liquidity without taking initial directional price exposure to a specific token. The goal is to earn yield from liquidity provision while minimizing exposure to asset price movements.

## TL;DR

- Max profit occurs when the price of tokens in LP remains at the entry price of the position.
- As long as trading fees and LP rewards earned exceed borrowing costs, the strategy remains profitable.
- If the price of tokens in LP moves significantly away from the entry price too quickly, potential losses may occur before enough trading fees and LP rewards are accumulated.
- This is a short volatility strategy—it benefits when price oscillates around the starting price, but sustained trends in either direction can lead to losses.

## Understanding Pseudo-Delta-Neutrality

The reason we call this strategy pseudo-delta-neutral is that, like options trading, the delta (price exposure) is not fixed. While the position starts delta-neutral (no price exposure), it gradually shifts as price moves due to liquidity mechanics.

In simple terms:

- The position is only truly delta-neutral at the entry price.
- Max profit occurs at the entry price since yield is highest without directional exposure.
- As price moves, the exposure to tokens in LP changes, making the strategy more directional over time.

## How It Works

### Example Setup

#### Initial Position Setup

- Assume S is priced at 1 USDC.e
- A user starts with 100 USDC.e as collateral.
- A 3X leveraged position is opened by borrowing 150 S and 50 USDC.e.
- The total position size is 300 USDC.e worth, which is split into:
  - 150 USDC.e worth of S (150 S borrowed)
  - 150 USDC.e (100 USDC.e collateral + 50 USDC.e borrowed)

#### Liquidity Provisioning

- The user provides liquidity into an S/USDC.e LP.
- The price range is set 5% above and below the starting price (i.e., 0.9–1.1 USDC.e).
- The LP earns fees from trading volume and reward from staking LP in this range.

#### Yield vs Borrowing Costs

- The position assumes a 40% APY borrow rate, which translates to 0.0922% daily interest.
- The expected yield from LP fees is 1.8% per day (higher than the borrow cost).
- The expected reward from LP staking is 1.75% per day
- As long as yield + reward > borrow rate, the strategy remains profitable.

#### What Happens as Price Moves?

- If price stays near 1 USDC.e, profits accumulate from trading fees and staking rewards.
- If price moves toward 0.9 or 1.1 USDC.e, exposure to S increases, reducing neutrality.
- If price breaks below 0.9 or above 1.1, the LP position exits the active range, reducing fee earnings and/or staking rewards.

## Profit & Risk Analysis

### Profit & Loss (PnL) Behavior

- Max profit occurs when S price stays at 1 USDC.e.
- If S price moves ±5–6% within 1 day, break-even is reached.
- If S price moves ±10% over 7 days, profits remain positive, but risk increases.
- If S price moves beyond the LP range before enough fees and staking rewards are earned, losses can occur.

### Short Volatility & Short Gamma Strategy

- This strategy is often called a "short volatility" or "short gamma" strategy.
- It performs well when price oscillates around the entry point.
- Sustained trending movements reduce profitability, as price exposure increases with movement.

### Choosing the Right Conditions

- **Best Case** → High trading volume near entry price (1 USDC.e) → High fee and reward earnings.
- **Worst Case** → Sudden, strong price movements away from 1 USDC.e before fees and reward accumulate.

### Risk Considerations

- **Impermanent loss risk** → The value of deposited liquidity may decrease if price moves out of range.
- **Borrowing cost risk** → If borrow APY increases or yield APY decreases, profitability may drop.
- **Market trend risk** → If S trends significantly in one direction, the position becomes directional.

## Summary

- Pseudo-Delta-Neutral LP aims to earn yield while reducing exposure to price movements.
- The strategy thrives when price fluctuates near the entry point and generates high trading volume.
- If price moves too quickly, losses can occur before yield is earned.
- Yield does not always equal total returns—consider price movement effects when using this strategy.

Mighty Finance provides tools to optimize pseudo-delta-neutral farming while helping users manage risk and maximize profitability.

# Risks

Mighty Finance is built to provide a seamless, efficient, and optimized DeFi experience, but like any decentralized financial platform, there are inherent risks. While we take extensive measures to enhance security and reduce vulnerabilities, users must understand and manage the risks involved in leveraged yield farming, lending, and liquidity provision.

## Smart Contract & Security Risks

- Mighty Finance operates through smart contracts, which are immutable once deployed. While rigorously audited, they remain vulnerable to exploits, coding errors, and unforeseen vulnerabilities.
- The platform interacts with external protocols (DEXes, lending pools, oracles), which carry their own risks. We do not control these third-party integrations and cannot guarantee their security.
- Hacks, exploits, and cyberattacks remain a persistent risk in DeFi, and users should only engage with funds they can afford to lose.

## Liquidation Risks

- Using leverage magnifies potential returns but also increases the risk of liquidation. If a position's debt ratio surpasses the liquidation threshold, it will be forcefully closed.
- Liquidations may not always occur immediately or at an optimal price, especially in times of network congestion or extreme market volatility.
- If liquidation bots fail to execute on time, bad debt may occur, and remaining collateral could be insufficient to cover the borrowed amount.

## Price Impact & Impermanent Loss Risks

- Price impact can affect execution when entering or exiting positions, especially in lower liquidity pools. Large trades may cause slippage, leading to unfavorable price execution.
- Impermanent loss is an inherent risk for liquidity providers when token prices shift significantly within a pool. This loss may become permanent in volatile market conditions.
- Concentrated liquidity pools generally amplify the impact of price fluctuations, making impermanent loss more pronounced.

## Network Congestion & Oracle Risks

- Blockchain congestion can lead to transaction delays, failed executions, or unexpected price movements, impacting trade outcomes.
- Mighty Finance relies on third-party price oracles (e.g., Chainlink, Pyth) to determine real-time market prices. Any oracle disruptions, inaccuracies, or manipulations could cause unexpected liquidations or mispriced trades.

## Lending & Liquidity Pool Risks

- High utilization rates in lending pools may delay withdrawals until borrowers repay their debts.
- If a lending pool reaches 100% utilization, borrowers may face higher interest rates, while lenders may be temporarily unable to retrieve their deposited funds.
- If liquidations fail to execute in time, bad debt can accumulate, leading to potential risks for liquidity providers and lenders.

## Wallet & Security Risks

- Mighty Finance is non-custodial—we do not control user assets or private keys. Users must take full responsibility for securing their wallets.
- The platform supports multiple wallet providers, but if a wallet service experiences a security breach, Mighty Finance cannot recover lost funds.
- Users should always verify wallet permissions before signing transactions and avoid interacting with unauthorized platforms.

## Regulatory & Compliance Risks

- The regulatory landscape for DeFi is constantly evolving. Future legal changes could impact platform operations or restrict access to certain jurisdictions.
- Users must confirm they are legally allowed to use DeFi services in their respective regions.
- Mighty Finance does not operate in prohibited jurisdictions such as the United States, China, North Korea, Iran, Syria, Cuba, and OFAC-sanctioned regions. Users from these locations must not engage with the platform.

## User Responsibility

- DeFi is inherently risky. Users must conduct their own research (DYOR) and understand how leverage, impermanent loss, and liquidations function before engaging.
- Invest only what you can afford to lose. Losses in DeFi can be irreversible.
- Mighty Finance does not guarantee profits, protection from liquidation, or immunity from market volatility.

Mighty Finance is designed to empower users with financial flexibility and advanced DeFi strategies, but success depends on understanding and managing risk effectively.

# Take Profit / Stop Loss

> Take Profit / Stop Loss is not supported at the beginning
>
> Please stick to the official announcement for update

Mighty Finance enables users to manage risk and secure gains using customizable Limit Orders, specifically through the use of Stop-Loss (Lower Limit, LL) and Take-Profit (Upper Limit, UL) orders. These orders help users automatically close positions when an asset reaches a certain price.

## How Limit Orders Work

- **Lower Limit (LL)**: Protects against downside risk or locks in profits if the price falls below your specified level. LL orders are placed below the current price.
- **Upper Limit (UL)**: Secures gains automatically if the price rises to your target. UL orders are placed above the current price.

## Setting LL/UL Orders

### At Position Creation:

- Click the "Limit Orders" button while opening a new position to define your LL/UL trigger prices.

### On Existing Positions:

- Select the open position from the "Opened Positions" table, and click on the "Limit Orders" panel to set or adjust your desired limits.

## Example Scenario

Consider the S/USDC liquidity pair:

- Liquidation Price: $0.90
- Stop-Loss (LL): $0.91

In highly volatile markets, prices can quickly move past both your set limits and liquidation threshold. To minimize risk, avoid setting LL/UL orders too close to your liquidation price.

## Execution & Fees

- LL/UL orders automatically close positions, returning the native asset (e.g., S for long positions, USDC.e for short positions).
- A 0.05% fee is charged when an LL/UL order is executed.
- Mighty Finance currently supports full-position closures only. Partial closures are not yet available.
- All associated LL/UL orders are automatically canceled once a position is closed, whether manually or via LL/UL execution.

## Managing Your Orders

- LL/UL orders appear in the "Opened Positions" table. Use the column filter if needed.
- Trigger prices for LL/UL orders can be manually adjusted based on market changes.

## Limit Orders Swap

Mighty Finance allows users to specify which token their position will be converted into upon LL/UL execution, ensuring a predictable and tailored exit strategy.

## Important Considerations

- Execution delays are possible during network congestion or extreme volatility. LL/UL orders are not guaranteed to execute immediately.
- Users are responsible for regularly monitoring positions and maintaining safe distances from liquidation prices.

By utilizing Mighty Finance's Take Profit & Stop Loss functionality, users gain enhanced control over their leveraged positions, optimizing both risk management and profit realization.

# Liquidation

Liquidation occurs when a position's Debt ratio (Debt to Value Ratio) exceeds the maintenance threshold. At this point, liquidators can step in to close the position, ensuring that borrowed funds are repaid to lenders.

Mighty Finance implements an optimized liquidation system that balances capital efficiency with user protection.

## Liquidation Process

1. When a Debt ratio surpasses the Liquidation Threshold, a liquidation is triggered to forcefully close the position.
2. Borrowed funds are repaid to the lending pool.
3. Any remaining collateral (after deducting a liquidation bounty) is returned to the user.
4. The liquidation process is time-sensitive and depends on blockchain congestion.

## Liquidation Thresholds

The liquidation threshold varies based on asset type of selected LP and market conditions:

- Stablecoin pairs: 80% Debt Ratio
- General asset pairs: 70% Debt Ratio
- High-risk assets: Subject to governance updates

These parameters may be adjusted based on market conditions and risk assessment models.

## Liquidation Incentive

To encourage timely liquidations, Mighty Finance introduces Liquidiation Incentive of 7.5% to the total position value.

## Partial Liquidation Mechanism

For low-liquidity pools and large positions, Mighty Finance uses a staged liquidation process:

1. Initial liquidation covers 50% of the position
2. If the position remains above the liquidation threshold, another 25% is liquidated
3. This process repeats until the position stabilizes or is fully closed

## Important Considerations

- Liquidation is not instant. Execution depends on network congestion and available liquidators.
- Borrowers should actively monitor their positions and adjust leverage accordingly.
- Yield farming rewards and trading fees are not factored into liquidation price calculations.

By combining real-time risk monitoring, automated liquidation triggers, and optimized discount structures, Mighty Finance ensures a robust and fair liquidation system for users and lenders alike.