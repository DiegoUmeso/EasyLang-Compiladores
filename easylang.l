
%{
#include <stdio.h>
#include "easylang.tab.h"
%}

%option yylineno noyywrap
%x COMENTARIO

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
"DO"|"do"               { return DO; }
"WHILE"                 { return WHILE; }
"FOR"                   { return FOR; }
"to"                    { return TO; }

"***"                   { BEGIN(COMENTARIO); }
<COMENTARIO>"***"       { BEGIN(INITIAL); }
<COMENTARIO>[^*\n]+     { }
<COMENTARIO>"*"         { }
<COMENTARIO>\n          { }
<COMENTARIO><<EOF>>     {
    fprintf(stderr, "Error lexico en linea %d: comentario sin cerrar\n", yylineno);
    BEGIN(INITIAL);
    return INVALIDO;
}

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

[0-9]+                  { return NUMERO; }

[a-zA-Z][a-zA-Z0-9]*    { return ID; }

[ \t\r\n]+              { }

.                       {
    fprintf(stderr, "Error lexico en linea %d: %s\n", yylineno, yytext);
    return INVALIDO;
}

%%
