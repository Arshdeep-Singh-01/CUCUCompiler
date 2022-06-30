%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>

	#define YYSTYPE char*

	#include"cucu.tab.h"
	
	void yyerror(const char* str);
	
	
%}

%%


\/\*[^(\/\*)]*\*\/   
\/\/.*  	


							/*For Assignment statements*/
(char[ \t]*(\*)+)   		{fprintf(yyout,"TYPE     : character pointer\n");return CHARPTR;}
(int)						{fprintf(yyout,"TYPE     : int\n");				 return INT;}
(return)					{fprintf(yyout,"RETURN STATEMENT\n"); 			 return RETURN;}
[0-9]+						{fprintf(yyout,"NUMBER: %s\n",yytext); 		yylval =strdup(yytext); return NUM;}
\,							{fprintf(yyout,"COMMA    : ,\n"); 				 return COMMA;}
\;							{fprintf(yyout,"SEMICOLON: ;\n");				 return SEMICOLON;}

							/*For arithmetic operators*/							
\+							{fprintf(yyout,"PLUS     : +\n"); return PLUS;}
\-							{fprintf(yyout,"MINUS    : -\n"); return MINUS;}
\*							{fprintf(yyout,"MULTIPLY : *\n"); return MULTI;}
\=							{fprintf(yyout,"EQUAL    : =\n"); return ASSIGN;}
\/							{fprintf(yyout,"DIVIDE   : /\n"); return DIV;} 
\&							{fprintf(yyout,"OR  : &\n"); return AND;}
\|							{fprintf(yyout,"AND : &\n"); return OR;}
"&&"						{fprintf(yyout,"LOGICAL AND: &&\n"); return LAND;}
"||"						{fprintf(yyout,"LOGICAL OR : ||\n"); return LOR;}

							/*For relational operators*/
(==)						{fprintf(yyout,"EQUAL TO : ==\n"); 			return EQUALTO;}
(!=)						{fprintf(yyout,"NOT EQUAL TO: !=\n"); 		return NEQUALTO;}
(\<=)	     				{fprintf(yyout,"LESS THAN EQUAL: <=\n"); 	return LESSEQ;}
(\>=) 						{fprintf(yyout,"GREATER THAN EQUAL: >=\n"); return GREATEQ;}
(\<)						{fprintf(yyout,"LESS THAN: <\n"); 			return LESS;}
(\>)						{fprintf(yyout,"GREATER THAN: >\n"); 		return GREAT;}

							/*For control statements*/
while						{fprintf(yyout,"WHILE LOOP\n"); 			return WHILE;}
if([ ]*)/"("				{fprintf(yyout,"IF STATEMENT\n"); 			return IF;}
else						{fprintf(yyout,"ELSE STATEMENT\n"); 		return ELSE;}
[A-Za-z]([A-Za-z0-9_])* 	{fprintf(yyout,"IDENTIFIER: %s\n",yytext);  yylval =strdup(yytext); return ID;}
\".*\"						{fprintf(yyout,"STRING: %s\n",yytext); 		yylval =strdup(yytext); return STRING;}

							/*For function names*/
([A-Za-z][A-Za-z0-9_]*)/"("  {fprintf(yyout,"FUNCTION NAME : %s\n",yytext); yylval =strdup(yytext); return FNNAME;}


	     
							/*braces/parenthesis*/
"{"							{fprintf(yyout,"OPENING BRACE: {\n"); return OBRACE;}
"}"							{fprintf(yyout,"CLOSING BRACE: }\n"); return CBRACE;}
"("							{fprintf(yyout,"OPENING PARENTHESIS: (\n"); return OPAR;}
")"							{fprintf(yyout,"CLOSING PARENTHESIS: )\n"); return CPAR;}
"["							{fprintf(yyout,"OPENING BRACKET: [\n"); return OBRACKET;}
"]"							{fprintf(yyout,"CLOSING BRACKET: [\n"); return CBRACKET;}

\n	       					
[ ]	       			
.							{fprintf(yyout,"others%s\n",yytext);}

%%

int yywrap(){
	return 1;
}


