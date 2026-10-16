# dr-quine

Quines written from scratch in C and x86-64 assembly, exploring self-reference and the ideas behind Kleene's recursion theorem: how a program can reproduce its own description and use it during execution.

A **quine** is a program that takes no input and prints its own exact source code, without reading that source from a file. Whitespace, comments, quotation marks, and the presence or absence of a final newline all count toward an exact match.

The project explores three variations of self-reproducing code:

* **Colleen** prints its own source to standard output. The C version calls a separate printing function; the assembly version calls a helper routine that writes directly through Linux system calls.
* **Grace** writes its own source into `Grace_kid.c`. Its C implementation uses three macros to define the output filename, the source template, and the entry point. Expanding `ENTRY` supplies the `main` function.
* **Sully** writes, compiles, and runs successive copies of itself, carrying a counter in each generated source. Starting at `5`, this implementation produces `Sully_5.c` through `Sully_0.c`, along with their executables. The copy with a counter of `0` exits without generating another file.

The `C/` directory contains all three implementations. The `ASM/` directory currently contains only `Colleen.s`; its Makefile also lists Grace and Sully, but their assembly sources are not present yet. The project subject is included in [`en.subject.pdf`](en.subject.pdf).

To build the C programs, you need `make` and a C compiler available as `cc`. Sully also invokes `gcc` at runtime to compile its children. Run the following from the repository root:

```sh
cd C
make
./Colleen | diff - Colleen.c
./Grace
diff Grace.c Grace_kid.c
./Sully
diff Sully.c Sully_5.c
cd ..
```

Each `diff` command should produce no output, indicating that the compared sources match. Later Sully generations differ from the original only in the value of `COUNT`. Grace and Sully write into the current working directory, so running them inside `C/` keeps their generated files together. Running them again overwrites the files with the same names.

The assembly implementation targets **x86-64 Linux**, using NASM's ELF64 output and direct Linux system calls. It requires `nasm`, `gcc`, and `make`. From the repository root, build the available target explicitly:

```sh
make -C ASM Colleen
./ASM/Colleen | diff - ASM/Colleen.s
```

Here too, an empty `diff` result means the output matches the source. A plain `make -C ASM` also attempts to build the currently missing Grace and Sully sources.

Both Makefiles provide `clean` to remove object files, `fclean` to remove objects and executables, and `re` to rebuild their full target list. `make -C C fclean` also removes `Grace_kid.c` and files matching `Sully_*` in `C/`. Use `make -C ASM fclean` to clean the assembly build.

## The Trick

Naively wrapping a program in a print statement turns into an infinite regress: the new program must also print that statement, including its quotes and escapes. Adding another wrapper only creates more source to reproduce.

Kleene's recursion theorem provides the theoretical basis for this kind of self-reference. The practical trick used here is to split the program in two:

* **Data**: A string literal containing a source template, with placeholders for characters and for the template itself.
* **Instructions**: The logic that expands the template and inserts an unchanged copy of it inside the generated string declaration.

The key is that the template does not contain a fully expanded copy of itself. It contains a placeholder for that copy. In C, passing the template both as the format string and as a `%s` argument fills that placeholder without another level of expansion: `printf` treats the inserted string as data, so any `%` characters inside it are printed literally.

This gives the same text two roles. The expanded template reconstructs the surrounding source code, while the unchanged copy reconstructs the string literal inside that source. The output is ordinary text; it becomes executable code only if it is compiled and run.

In **C**, `%c` placeholders supply characters that would otherwise complicate quoting: `10` for a newline, `34` for a double quote, and, in Colleen, `9` for a tab. Colleen uses `printf` to send the result to standard output, while Grace uses `fprintf` to write it to a file. Both preserve their comments and formatting as part of the template.

Sully adds a changing value to the same mechanism. Its format string uses positional arguments such as `%1$c` for newlines and `%4$d` for the next counter value. A `%%d` in the template emits a literal `%d` for a generated program's own filename or command format string. The original executable starts with `COUNT` set to `5`; generated children are compiled with `-D CHILD`, which enables the decrement before they write the next generation. This is why the first generated source still has a counter of `5`, while subsequent copies count down to `0`.

In **assembly**, Colleen implements its own template expansion instead of calling `printf`. The `data_` string uses three marker characters:

* **`|`** emits a newline.
* **`~`** emits a single quote, matching NASM's string delimiter in this source.
* **`@`** emits the entire unchanged template, excluding its terminating null byte.

The helper scans the template one byte at a time, copying ordinary characters and expanding these markers with the Linux `write` system call. At `@`, it writes the raw template directly without scanning that inserted copy again. This is the same self-reference mechanism as the C version, expressed explicitly with registers, a loop, and system calls.

## Resources

* **[Reflections on Trusting Trust](https://www.cs.cmu.edu/~rdriley/487/papers/Thompson_1984_ReflectionsonTrustingTrust.pdf)** – Ken Thompson's classic 1984 Turing Award lecture on the security implications of self-replicating code and compiler backdoors.
* **[Gödel, Escher, Bach: An Eternal Golden Braid](https://www.physixfan.com/wp-content/files/GEBen.pdf)** – Foundational literature by Douglas Hofstadter detailing the mechanics of formal systems, recursion, and self-reference.
* **[A Quine in x86-64 Assembly](https://blog.lxgr.net/posts/2013/05/10/a-quine-in-x86-64-assembly/)** – A practical technical breakdown of how to structure a quine at the lower architecture level.
