%{
#include "easylang.tab.h"
%}

%option yylineno

%%

"MAIN"                  { return MAIN; }
"BEGIN"                 { return BEGIN1; }
"END"                   { return END; }
"ALLOCATE"              { return ALLOCATE; }
"INPUT"                 { return INPUT; }
"OUTPUT"                { return OUTPUT; }
"IF"                    { return IF; }
"THEN"                  { return THEN; }
"ELSE"                  { return ELSE; }
"AND"                   { return AND; }
"OR"                    { return OR; }
"DO"|"do"                    { return DO; }
"WHILE"                 { return WHILE; }
"FOR"                   { return FOR; }
"to"                    { return TO; }

"***"([^*]|\*+[^*])*\*{3}    { /* Ignorar comentarios */ }

"**"                    { return POTENCIA; }
"+"                     { return SUMA; }
"-"                     { return RESTA; }
"*"                     { return MULTIPLICACION; }
"/"                     { return DIVISION; }

">="                    { return MAYORIGUAL; }
"<="                    { return MENORIGUAL; }
"=="                    { return IGUAL; }
"<>"                    { return DIFERENTE; }
">"                     { return MAYOR; }
"<"                     { return MENOR; }

":="                    { return ASIGNACION; }
";"                     { return PUNTOYCOMA; }
":"                     { return DOSPUNTOS; }
"("                     { return PARIZQ; }
")"                     { return PARDER; }

-?[0-9]+                  { return NUMERO; }

[a-zA-Z][a-zA-Z0-9]*    { return ID; }

[ \t]                   { /* Ignorar espacios */ }

\n                      { /* Ignorar saltos de linea */ }

.                       { printf("Error lexico en linea %d: %s\n", yylineno, yytext); return -1;}

%%
