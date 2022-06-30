# CUCUCompiler

## How to run

Run the following command
```
1.   bison -d cucu.y
2.   flex cucu.l
3.   g++ cucu.tab.c lex.yy.c -lfl -o cucu
4.   ./cucu Sample1.cu 

```
