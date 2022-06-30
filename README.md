# CUCUCompiler

## How to run

Run the following command
```
 bison -d cucu.y
 flex cucu.l
 g++ cucu.tab.c lex.yy.c -lfl -o cucu
 ./cucu Sample1.cu 

```
