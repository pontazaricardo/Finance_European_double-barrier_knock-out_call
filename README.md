# Finance_European_double-barrier_knock-out_call

This program calculates the price of European double-barrier knock-out calls by the use of binomial trees and Monte Carlo Simulations.

## INPUTS AND OUTPUTS
1. **Inputs:** *S* (stock price), *X* (strike price), *H* (high barrier), *L* (low barrier), *t* (year), *s* (volatility in %), *r* (continuously compounded interest rate in %), and *n* (number of periods). 
2. **Output:** Prices given by both the binomial tree and the Monte Carlo simulation.

## NOTES

Assume *L* < *S* < *H*.

## USAGE
In MatLab, just run the given file.

## EXAMPLE
Suppose *S* = 95, *X* = 100, *H* = 140, *L* = 90, *t* = 1 (year), *s* = 25 (%), *r* = 10 (%), and *n* = 1000:
	1. The price given by the tree is 1.457
	2. The price given by the 1.5 (varies depending on the amount of paths of the Monte Carlo simulation).
