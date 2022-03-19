+++
title = "Explaining what is P-value and how to calculate it"
date = "2021-11-22"
description = "In this article I explain what is the p-value and how to calculate it."
tags = [
    "statistics",
    "p-value"
]
draft = false
toc = true
share = true
+++


{{<audio src="https://s3.eu-west-1.amazonaws.com/jaswdr.dev-tts/posts/p-value.f8f2ba8f-ae13-435c-8366-6e1bdec69c1b.mp3?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFsaCXVzLWVhc3QtMSJHMEUCIAls5E1u2te39hRgrBja5wOcLPoheem%2FKaIBB3dxWeD6AiEAig%2BiKnNzMNLd6QVX0PA0uoPUEEzS8yaTRC%2F97wwYwVoq8QII1P%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARABGgwwNDkzNjYyMDIyNjUiDMsaINpVaG8qGcELeirFAqJQnxhqjktlEwex3owJuTeLC3ZRZeew4hgXf8uVjADvJxwO5f%2FYXMxY1zahzREEdkGroZk6seZeZF8O7pzCKnp8hQkpv%2BgPuQCisoKDIuZ5ssLWslB%2FQdkk4JcUEL2i9ivZMnxzWNgOAFdF%2FeHpd94d0PK2lPoeSGVREItkM7yQUk24Z3pUN1OlVxoZ30eH1COA95IY86mEtC0Z1tNoZyAbd7UUhmRZ50WoX3hhf9euhRshbXtWYy1ItlZyZlSDTJT3BaZEu5O1fW1mw%2FRU0kXRyIC7epMovywgr1HTtykq60RoeiBlqyxZFn16IkB%2F45vwpoxm%2BoLWeAFSpQymnMNmYWQCJ8rew3MgpiZulgttuge7oCQl8tfXd%2F2l8TUnO%2FiPMVfmOfIi5NZD036TWV6APezZWKx5X76OoY0eS4EPuYOXVasw2e7WkQY6swL4bKd6EWMvcqSsyXecOoZlMoGwL%2BpIjn6d4IdjEhIWiu%2BiQ9Op0u2jY8MCdhnuhUBVgpOJvb4VsizEA4w5ZnEq5qALKC80zYBHTIGePhA7USAefn1dpvmMgtqSrUAEZ9AFH2z6zAzlfWQMOushX%2BIiEHmJw9Ca2oSD8kcnFYIYwvcdkksse7zdre79Ru9cOn2mwm8KLMIeErkxHp6h4Kh8ZvociMyTwqbXa0RUi2cRCTe9c1yV7mmTxqMMlb7p6yAl3UyRMs89gFtpu2iq0T5p4rOF6CkWx8376K3pyUn47AkNYCRLMjU5XEkGHrsCDrzH2%2FumIALSjhUDj52vzKKMwZhqu3eoO%2B0JgRYit1L6k9zJNo3d5V8IzjZkZQXa3OjWzE4dp90t3YjMJ3%2Be%2BKWAvKPO&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220319T110447Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIAQW7TUO6M4CMHVQOI%2F20220319%2Feu-west-1%2Fs3%2Faws4_request&X-Amz-Signature=46a2f38320138079e003c7e39ca3c80dc0157b367ebc5c6f766456370427c62a">}}

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
