"""This file contains code used in "Think Stats",
by Allen B. Downey, available from greenteapress.com

Copyright 2013 Allen B. Downey
License: GNU GPLv3 http://www.gnu.org/licenses/gpl.html
"""

"""This file contains a partial solution to a problem from
MacKay, "Information Theory, Inference, and Learning Algorithms."

    Exercise 3.15 (page 50): A statistical statement appeared in
    "The Guardian" on Friday January 4, 2002:

        When spun on edge 250 times, a Belgian one-euro coin came
        up heads 140 times and tails 110.  'It looks very suspicious
        to me,' said Barry Blight, a statistics lecturer at the London
        School of Economics.  'If the coin weere unbiased, the chance of
        getting a result as extreme as that would be less than 7%.'

MacKay asks, "But do these data give evidence that the coin is biased
rather than fair?"

"""

import thinkbayes
import myplot


class Euro(thinkbayes.Suite):

    def Likelihood(self, hypo, data):
        """Computes the likelihood of the data under the hypothesis.

        hypo: integer value of x, the probability of heads (0-100)
        data: string 'H' or 'T'
        """
        prob_heads = hypo
        flip_result = data

        # You have the luxury of Hypothesis IS TRUE
        # Take it for granted!
        # What is the probability of 'Head', given the probability of head is 60%!!!!
        if data == 'H':
            return x
        else:
            return 1-x


def main():
    suite = Euro(range(0, 101))

    myplot.Pmf(suite)
    myplot.Show()
    

if __name__ == '__main__':
    main()
