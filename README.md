# dr-quine

Quines written from scratch in C and x86-64 assembly, exploring Kleene's recursion theorem. the proof that a program can obtain its own source code and use it during execution.

A **quine** is a program that takes no input and prints its own exact source code.

## The Trick

Naively printing our own source turns into an infinite regress: to `printf("hello")` we'd have to print `printf("printf(\"hello\")")`, which is now longer, so we'd have to print that, forever.

Kleene's theorem breaks the loop by splitting the program in two:

* **Data**: A string literal holding the code as raw text.
* **Instructions**: The logic that prints that string twice: once quoted (as data), and once unquoted and executed (as code).

## Resources

* **[Reflections on Trusting Trust](https://www.cs.cmu.edu/~rdriley/487/papers/Thompson_1984_ReflectionsonTrustingTrust.pdf)** – Ken Thompson's classic 1984 Turing Award lecture on the security implications of self-replicating code and compiler backdoors.
* **[Gödel, Escher, Bach: An Eternal Golden Braid](https://www.physixfan.com/wp-content/files/GEBen.pdf)** – Foundational literature by Douglas Hofstadter detailing the mechanics of formal systems, recursion, and self-reference.
* **[A Quine in x86-64 Assembly](https://blog.lxgr.net/posts/2013/05/10/a-quine-in-x86-64-assembly/)** – A practical technical breakdown of how to structure a quine at the lower architecture level.
