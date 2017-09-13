# Finance_European_double-barrier_knock-out_call

This program calculates the price of European double-barrier knock-out calls by the use of binomial trees and Monte Carlo Simulations.

![demo](/images/demo.gif)

## Inputs and Outputs

For this program, we have:
1. **Inputs:** *S* (stock price), *X* (strike price), *H* (high barrier), *L* (low barrier), *t* (year), *s* (volatility in %), *r* (continuously compounded interest rate in %), and *n* (number of periods). 
2. **Output:** Prices given by both the binomial tree and the Monte Carlo simulation.

### Notes

We need to assume *L* < *S* < *H*, i.e., the stock price is always between the lower and high barrier.

## Usage
In MatLab, just run the given file.

## Example
Suppose *S* = 95, *X* = 100, *H* = 140, *L* = 90, *t* = 1 (year), *s* = 25 (%), *r* = 10 (%), and *n* = 1000:
	1. The price given by the tree is 1.457
	2. The price given by the 1.94 (varies depending on the amount of paths of the Monte Carlo simulation).

![demo](/images/pic18_c.png)

Because the second value is given by a Monte Carlo simulation, it will vary from run to run, as seen when comparing the image above with the image below.

![demo2](/images/pic18.png)

In the previous two images we can see that the value of the Monte Carlo simulations shifted from 