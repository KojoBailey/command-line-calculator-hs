# Command-Line Calculator - Haskell
This script in Haskell is a very simple command-line calculator that can take an expression as IO string input and evaluate it.

> [!TIP] Example
> ```haskell
> Enter your calculation to compute:
> >>> 3 + 4 * 5
> 23
> ```

## Motivation
I'm learning Haskell in university, so here's another project of mine to put learning to practice. My other Haskell projects can be found on my GitHub.

In particular, I wanted to do a "string expression evaluator" since it's a good way to practice using binary trees and is also a good start to eventually create an interpreter for a custom programming language. Chances are, I'll take this Haskell project once it's complete and try implementing it in C++, since that's my current language of preference.

## To-do
This project is not quite finished. I still need to implement:

### Order of operations
It currently just takes priority from right-to-left.

```
>>> 3 * 4 + 5
```

**Expected output:** `17` (12 + 5)

**Current output:** `27` (3 * 9)

### Decimal outputs
Currently, only integers are possible outputs.

```
>>> 9 / 4
```

**Expected output:** `2.25`

**Current output:** `2`

### Decimal inputs
Currently, only integers are possible inputs as well.

```
>>> 2.3 * 3
```

**Expected output:** `6.9`

**Current output:** `*** Exception: Maybe.fromJust: Nothing`

### Parentheses
Parentheses are essential for clear expressions.

```
>>> 3 * (4 + 5)
```

**Expected output:** `27` (3 * 9)

**Current output:** `*** Exception: Maybe.fromJust: Nothing`