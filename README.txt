How to run:
    For running :
1.   bison -d cucu.y
2.   flex cucu.l
3.   g++ cucu.tab.c lex.yy.c -lfl -o cucu
4.   ./cucu Sample1.cu 


Assumptions/Rules:
1. main function should have atleast one statement and return statement should be there.
2. whenever the program finds some ERROR it terminates.
3. only int and char * are used as the type of variable, hence "char a" would give error.
4. As per grammer rules given in the problem associativity and precedence have been allowed
5. In addition to this other operators are also allowed but thir precedence have not been considered like <= >= < > have same precedence.
