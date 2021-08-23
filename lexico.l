%{
#include <stdio.h>
#include <conio.h>
extern int yyparse();
int yyerror(char*s);

#include "sintactico.tab.h"

%}

%option noyywrap
%option yylineno

ignore " "|\t|\n
caracter [A-Za-z]
digito [0-9]
boleano "true"|"false"

%%

{ignore}				{;}
"."					{return ('.');}
"{"					{return ('{');}
"}"					{return ('}');}
";"					{return (';');}
","					{return (',');}
"("					{return ('(');}
")"					{return (')');}
"["					{return ('[');}
"]"					{return (']');}
"si"					{return IF;}
"otra_condi"				{return IFELSE;}
"sino"					{return ELSE;}
"principal"					{return PRINCIPAL;}
"entero"				{return ITGR;}
"decimal"				{return DOU;}
"bool"					{return T_F;}
"text"					{return TEXT;}
"para"					{return FOR;}
"mientras"				{return WHILE;}
"+"					{return SUMA;}
"-"					{return RESTA;}
"*"					{return MULTIPLICACION;}
"/"					{return DIVISION;}
"++"					{return AUMENTAR;}
"--"					{return DISMINUIR;}
":="					{return ASIGNADOR;}
">"					{return MAYOR;}
"<"					{return MENOR;}
"=="					{return IGUAL;}
">="					{return MAYORIGUAL;}
"<="					{return MENORIGUAL;}
"<>"					{return DIFERENTE;}
{digito}+				{return ENTERO;}
{digito}+"."{digito}			{return DECIMAL;}
{boleano}				{return BOLEANO;}
"\""({digito}|{caracter}|" ")*"\""	{return CADENA;}
{caracter}({caracter}|(digito))*	{return NOMBRECAMPO;}
.					{printf("error lexico en la linea: %d\n",yylineno);}


%%
yyerror(char *msg){
printf("%s\n", msg);
}

int main(void)
{
char nombreArchivo[50];
printf("Nombre del archivo:");
gets(nombreArchivo);
yyin = fopen(nombreArchivo, "rt");
if(yyin == NULL)
{
printf("\nNo se puede leer el archivo");
}
else
{
yyparse();
}
fclose(yyin);
getch();
}