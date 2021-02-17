%{
#include<stdio.h>



extern FILE* yyin ;
extern int count ;
extern int line;
int yylex();
// bool recherche_syn(char * name);
//void wrap();
int yyerror(char * msg);



%}

%token integer real car string mc_proc mc_prog mc_loop mc_arr mc_const mc_integer mc_real mc_car mc_string mc_read mc_write mc_while mc_execut mc_if mc_endif mc_else mc_arithOp mc_logiqOp mc_signeForma mc_sep mc_idf
%token var_sep
%left ADD_OP
%left MUL_OP


%start S
%%

S: header begin var_dec End {printf("programme juste\n"); YYACCEPT;};
begin: '{';
var_dec: type ':'':' list_var | mc_const type ':'':' list_var;
type: mc_string | mc_car | mc_integer | mc_real;
list_var: var '$' var_dec | var var_sep list_var | var '$' ;
var: affectation | mc_idf {printf("idf was found\n");} ;
affectation: mc_idf mc_arithOp expression;
expression: operation operande expression | operation;
operande: MUL_OP | ADD_OP;
operation: mc_idf | integer | real | car | string | '(' expression ')';
header: Bib_dec mc_prog mc_idf  
| mc_prog mc_idf;
Bib_dec: '#''#' bib Bib_dec | '#''#' bib;
bib:mc_arr | mc_proc | mc_loop;
End: '}';

%%

int yyerror(char *msg)
{

printf("%s syntaxic error line %d cologne %d\n",msg,line,count);

return 1;
}


int main(int argc , char **argv)
{	
	if(argc != 2)
	{
		printf("Error need missing file argument");
	}
	else
	{
		yyin = fopen(argv[1],"r");
		yyparse();
	}
	//printf("Count = %d \n",count);
	
}

int yywrap(void)
{
}
