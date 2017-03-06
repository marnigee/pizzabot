# Pizzabot Code Challenge

## Introduction

I had a great time working on this code challenge!

My basic approach here was to tackle the core functionality without any unnecessary complexities.

If this had been a real ticket, I would have reached out to the Product Owner to ask about how to manage the repeated `(4, 2)` house. I thought perhaps it represented an apartment building with more than one occupant with an order, so I had Pizzabot treat it as such: an additional `D` pizza drop without any moves. But it's perfectly valid to argue that it should be treated as an error and the house list needs to be cleared of potential duplicates at the start.

I look forward to getting feedback on how to improve this app. (I consistently ask myself how I can make my code better, and code review is such a good vehicle for that!).

<%)

## Dependencies

You will need:

* a modern version of Ruby (2.1.6 or greater)

## Setup

Install the dependencies:

```bash
$ gem install bundler # if you don't have it
$ bundle install
```

## Tests

To test the app, run the following command:

```bash
$ ruby test/pizzabot_test.rb
```

You should see something similar to the following output.
```bash
$ ruby test/pizzabot_test.rb
Run options: --seed 63331

# Running:

........

Fabulous run in 0.001374s, 5821.7045 runs/s, 5821.7045 assertions/s.

8 runs, 8 assertions, 0 failures, 0 errors, 0 skips
```

## Challenge Instructions

These were the code challenge instructions: 

> As part of our continuing commitment to the latest cutting-edge pizza technology research, Slice is working on a robot that delivers pizza. We call it *(dramatic pause)*: Pizzabot. Your task is to instruct Pizzabot on how to deliver pizzas to all the houses in a neighborhood.
>
> In more specific terms, given a grid (where each point on the grid is one house) and a list of points representing houses in need of pizza delivery, return a list of instructions for getting Pizzabot to those locations and delivering. An instruction is one of:
>
> ```
> N: Move north
> S: Move south
> E: Move east
> W: Move west
> D: Drop pizza
>
> ```
>
> Pizzabot always starts at the origin point, (0, 0). As with a mathematical graph, this point lies at the most south-westerly point of the grid.
>
> Therefore, given the following input:
>
> ```
> $ ./pizzabot 5x5 (1, 3) (4, 4)
> ```
>
> one correct solution would be:
>
> ```
> ENNNDEEEND
>
> ```
>
> In other words: move east once and north thrice; drop a pizza; move east thrice and north once; drop a final pizza.
>
> There are multiple correct ways to navigate between locations. We do not take optimality of route into account when grading: all correct solutions are good solutions.

## Challenge Completion

> To complete the challenge, please solve for the following input:
>
> ```
> $ ./pizzabot 5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)
> ```
>
> 

My version of Pizzabot does not read from STDIN but instead returns this solution in the `test_delivery_with_multiple_directions_and_locations` test: 

```
ENNNDEEENDSSDDWWWWSDEEENDWNDEESSD
```
