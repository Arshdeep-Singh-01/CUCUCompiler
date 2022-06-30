%{
	#include <stdio.h>
	#include <string.h>	

	#define YYSTYPE char*

	int yylex(void);
	void yyerror(const char *);
	FILE *fout = fopen("Parser.txt","w");
%}
	
%token CHARPTR INT RETURN ID NUM STRING COMMA SEMICOLON PLUS MINUS MULTI ASSIGN DIV OPAR CPAR OBRACE CBRACE EQUALTO NEQUALTO LESSEQ GREATEQ LESS GREAT WHILE IF
%token ELSE FNNAME OBRACKET CBRACKET ARR_NAME AND OR LAND LOR
%start PRG	
%%

PRG: GLOBAL_STMTS{fprintf(fout,"Global Variables above:\n\n");} PRG												
	| FUNCTION_def PRG
	| FUNCTION_dec PRG
	| GLOBAL_STMTS								 			{fprintf(fout,"Global Variable above:\n\n");}
	| FUNCTION_def
	| FUNCTION_dec
	;

VAR_DEC: ID{fprintf(fout,"Var- %s\t",$1);} COMMA VAR_DEC
	| ID SEMICOLON											{fprintf(fout,"Var- %s\n",$1);}
	;

VAR_DEC: TYPE ID SEMICOLON						 	
	;


FUNCTION_dec: FUNCTION_init OPAR ARGS_dec CPAR SEMICOLON  {fprintf(fout,"\n");}
	;

ARGS_dec: ARG_dec COMMA ARGS_dec					
	| ARG_dec 
	;
ARG_dec: TYPE ID   									{fprintf(fout,"Function arg: %s\t",$2);}
	| RET_TYPE
	|
	;

FUNCTION_def: FUNCTION_init OPAR ARGS_dec CPAR{fprintf(fout,"\n");} OBRACE STMTS CBRACE  
	;
	
FUNCTION_init: RET_TYPE FNNAME             			{fprintf(fout,"Function- %s\n",$2);}
	;

RET_TYPE: TYPE
	| "void"
	;

TYPE: INT                                         
	| CHARPTR
	;


FUNCTION_CALL: FNNAME{fprintf(fout,"Function Call- %s\n",$1);} OPAR{fprintf(fout,"Function arg: ");} ARG CPAR {fprintf(fout,"\n");}
	;


ARG : EXPR COMMA{fprintf(fout,",\t");} ARG								
	| STRING {fprintf(fout,"String: %s\n",$1);}COMMA ARG
	| STRING {fprintf(fout,"String: %s\n",$1);}										
	| EXPR
	|
	;

STMTS: GLOBAL_STMTS STMTS					
	| IF_STMT STMTS
	| WHILE_LOOP STMTS
	| FUNCTION_CALL SEMICOLON STMTS
	| WHILE_LOOP
	| IF_STMT
	| GLOBAL_STMTS
	| RETURN_STMT
	| FUNCTION_CALL SEMICOLON
	;

GLOBAL_STMTS: ASSIGN_STMT					
	| TYPE VAR_DEC					
	;

RETURN_STMT: RETURN{fprintf(fout,"return\t");} EXPR SEMICOLON	{fprintf(fout,"\n");}
	;

ASSIGN_STMT: TYPE ASSIGN_init EXPR SEMICOLON					{fprintf(fout,"Declaration & Assignment Statement\n");}
	| ASSIGN_init EXPR SEMICOLON								{fprintf(fout,"Assignment Statement\n");}
	;
ASSIGN_init: ID ASSIGN											{fprintf(fout,"Var- %s\t=\t",$2);}
	;

EXPR: ATERM EQUALTO{fprintf(fout,"==\t");} EXPR							
	| ATERM NEQUALTO{fprintf(fout,"!=\t");} EXPR
	| ATERM LESS{fprintf(fout,"<\t");} EXPR
	| ATERM LESSEQ{fprintf(fout,"<=\t");} EXPR
	| ATERM GREAT{fprintf(fout,">\t");} EXPR
	| ATERM GREATEQ{fprintf(fout,">=\t");} EXPR
	| ATERM
	;

ATERM: BTERM LAND{fprintf(fout," &&\t");} ATERM								
	| BTERM LOR{fprintf(fout," ||\t");} ATERM								
	| BTERM
	;

BTERM: CTERM AND{fprintf(fout," &\t");} BTERM								
	| CTERM OR{fprintf(fout," |\t");} BTERM								
	| CTERM
	;

CTERM: DTERM PLUS{fprintf(fout," +\t");} CTERM								
	| DTERM MINUS{fprintf(fout," -\t");} CTERM								
	| DTERM
	;

DTERM: FACTOR MULTI{fprintf(fout," *\t");} DTERM							
	| FACTOR DIV{fprintf(fout," \\t");} DTERM								
	| FACTOR
	;

FACTOR: ID												{fprintf(fout,"Var- %s\t",$1);}
	| NUM												{fprintf(fout,"Const- %s\t",$1);}
	| OPAR EXPR CPAR
	| ARR_ELEMENT
	| FUNCTION_CALL
	;

ARR_ELEMENT: ID OBRACKET EXPR CBRACKET
	;


IF_STMT:IF_init OBRACE STMTS CBRACE ELSE_STMT			{fprintf(fout,"If-else Statements end\n");}
	| IF_init OBRACE STMTS CBRACE						{fprintf(fout,"If Statement end\n");}
	;

IF_init: IF {fprintf(fout,"If Statement\n");} OPAR EXPR CPAR                 {fprintf(fout,"\n");}
	;

ELSE_STMT: ELSE OBRACE STMTS CBRACE
	;


WHILE_LOOP:	WHILE_init OBRACE STMTS CBRACE									{fprintf(fout,"\n");}
	;
WHILE_init: WHILE{fprintf(fout,"While Loop\n");} OPAR EXPR CPAR				{fprintf(fout,"\n");}
	;


%%

void yyerror(const char* str){
	printf("%s\n",str);
}

int main(int argc, char* argv[])
{
	extern FILE* yyout;
	extern FILE* yyin;
	yyout = fopen("Lexer.txt","w");
	yyin = fopen(argv[1],"r");
	
    printf("readingdone\n");
	yyparse();
	return 0;
}