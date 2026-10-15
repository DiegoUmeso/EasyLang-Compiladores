%{
#include <stdio.h>

void yyerror(const char *mensaje);
int yylex(void);
int yyparse(void);
%}

%token MAIN
%token BEGIN1
%token END
%token ALLOCATE
%token INPUT
%token OUTPUT
%token IF
%token THEN
%token ELSE
%token AND
%token OR
%token DO
%token WHILE
%token FOR
%token TO

%token ID
%token NUMERO
%token INVALIDO

%token SUMA
%token RESTA
%token MULTIPLICACION
%token DIVISION
%token POTENCIA

%token MAYOR
%token MENOR
%token MAYORIGUAL
%token MENORIGUAL
%token IGUAL
%token DIFERENTE

%token ASIGNACION
%token PUNTOYCOMA
%token DOSPUNTOS
%token PARIZQ
%token PARDER

%%

inicio: programa
;

programa: MAIN BEGIN1 bloque END
;

bloque: elemento
    | bloque elemento
;

elemento: sentencia_simple PUNTOYCOMA
    | sentencia_compuesta
    | sentencia_compuesta PUNTOYCOMA
;

sentencia_simple: asignacion
    | lectura
    | escritura
    | declaracion
;

sentencia_compuesta: ciclo_do
    | ciclo_for
    | condicional
;

asignacion: ID ASIGNACION expresion
;

ciclo_for: FOR ID ASIGNACION expresion TO expresion DO BEGIN1 bloque END
;

ciclo_do: DO instrucciones_do WHILE PARIZQ condicion PARDER
;

instrucciones_do: sentencia_simple PUNTOYCOMA
    | instrucciones_do sentencia_simple PUNTOYCOMA
;

condicional: IF PARIZQ condicion PARDER THEN BEGIN1 bloque END ELSE BEGIN1 bloque END
;

condicion: comparacion
    | condicion AND comparacion
    | condicion OR comparacion
;

comparacion: expresion MENOR expresion
    | expresion MAYOR expresion
    | expresion MENORIGUAL expresion
    | expresion MAYORIGUAL expresion
    | expresion IGUAL expresion
    | expresion DIFERENTE expresion
;

expresion: expresion SUMA termino
    | expresion RESTA termino
    | termino
;

termino: termino MULTIPLICACION potencia
    | termino DIVISION potencia
    | potencia
;

potencia: factor POTENCIA potencia
    | factor
;

factor: PARIZQ expresion PARDER
    | RESTA factor
    | ID
    | NUMERO
;

lectura: INPUT ID
;

escritura: OUTPUT ID
;

declaracion: variable otra_variable ALLOCATE
;

otra_variable: DOSPUNTOS variable otra_variable
    | vacio
;

variable: ID
;

vacio:
;

%%

int main(void) {
    if (yyparse() == 0) {
        printf("Sintaxis correcta\n");
        return 0;
    }

    return 1;
}

void yyerror(const char *mensaje) {
    extern int yylineno;
    extern char *yytext;

    fprintf(stderr, "Error: %s en la linea %d cerca de %s\n",
            mensaje, yylineno, yytext);
}
