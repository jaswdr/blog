+++
title = "Explaining what is P-value and how to calculate it"
date = "2021-11-22"
description = "In this article I explain what is the p-value and how to use it."
tags = [
    "statistics",
    "p-value"
]
draft = false
toc = true
share = true
+++

### Definition

By definition, the P-value is a measure of the probability of obtaining a result that differs from the null hypothesis. Null Hypothesis is the hypothesis that the result is the same as the one we are testing, in other words that nothing has changed.

The P-value is a number between 0 and 1. The closer to 0 the p-value is, the more likely the result is to differ from the null hypothesis. Otherwise, if the p-value is closer to 1, the result is more likely to be the same as the null hypothesis.

### How to calculate?

To calculate the p-value, we sum 3 components:

1. The probability of the result being the observation.
2. The probability of the result being something else that is equally rare to the observation.
3. The probability of observing something rarer or more extreme than the observation.
4. 

Let’s see an example in practice.

### Example
You have flipped a coin 2 times. Both times the coin landed on heads. You think that your coin is special, and you want to know if it is. To check that, you start with the Null Hypothesis.

- Null Hypothesis (H0): Even though my coin landed heads twice in a row, it does not differ from any other coin.
- The alternative hypothesis (H1): My coin is special.

The potential outcomes for flipping a coin 2 times are:

- Heads and Heads
- Heads and Tails
- Tails and Heads
- Tails and Tails

With those possibilities in mind, we can calculate the p-value using the 3 components I previously mentioned.

1. The probability of the result being the observation.
one possibility of it being heads and heads out of four outcomes.

```
1/4 = 0.25
```

2. The probability of the result being something else that is equally rare to the observation.
1 possibility of it being Tails and Tails, out of 4 outcomes.

```
1/4 = 0.25
```

3. The probability of observing something rarer or more extreme than the observation.
There is no other possibility that is more rarer or extreme that the observation, so it is 0.

Now we can calculate the p-value.

```
P-value = 0.25 + 0.25 + 0 = 0.5
```

With the P-value in hand, we define the threshold of significance. A common threshold is 0.05, so if the p-value is lower than 0.05, we can say that the result differs from the null hypothesis. In our case, the P-value is 0.5, which is higher than 0.05, so we can say that the result is the same as the null hypothesis.
The conclusion is that our coin is not special.
