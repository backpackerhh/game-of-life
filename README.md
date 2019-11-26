# Conway's Game of Life

This is a plain Ruby implementation of "Conway's Game of Life". Conway's game is a mathematical simulation where cells live or die based on certain rules.

## Rules

The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead. Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

- Any live cell with fewer than two live neighbours dies, as if caused by under-population.
- Any live cell with two or three live neighbours lives on to the next generation.
- Any live cell with more than three live neighbours dies, as if by overcrowding.
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every cell in the seed - births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick (in other words, each generation is a pure function of the preceding one). The rules continue to be applied repeatedly to create further generations.

## Dependencies

This code depends on [RSpec](https://github.com/rspec/rspec) to run the test suite.

In order to install dependencies run:

```
bundle install
```

To run specs execute on terminal:

```
rspec
```

## Notes

* The motivation to develop this code was the event [Code Retreat 2019](https://www.coderetreat.org/).
* This code has been fully tested using TDD.
* I haven't used OOP here because I don't see how to do it without a `cell` object knowing too much about the matrix itself (world, board...whatever you prefer to name it).
* There are some limitations, such as the need of an array of arrays or a matrix containing only boolean values.
