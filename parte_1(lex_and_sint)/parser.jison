/* description: Parses end executes mathematical expressions. *

/* lexer */
%lex

%%
\s+                   	/* skip whitespace */
\"[^\"]*\"             	return 'STR';

/* keywords */
'BEGIN'             console.log("LEXEMA = "+yytext);return 'BEGIN';
'END'               console.log("LEXEMA = "+yytext);return 'END';
'ENDDEC'            console.log("LEXEMA = "+yytext);return 'ENDDEC';
'BEGINDEC'          console.log("LEXEMA = "+yytext);return 'BEGINDEC';
'WRITE'             console.log("LEXEMA = "+yytext);return 'WRITE';

/* variables types */
'VAR'               console.log("LEXEMA = "+yytext);return 'VAR';
'CONST'             console.log("LEXEMA = "+yytext);return 'CONST';

/* data types */
'INTEGER_TYPE'      console.log("LEXEMA = "+yytext);return 'INTEGER_TYPE';
'STRING_TYPE'       console.log("LEXEMA = "+yytext);return 'STRING_TYPE';

/* conditional structures */
'WHILE'             console.log("LEXEMA = "+yytext);return 'WHILE';
'IF'                console.log("LEXEMA = "+yytext);return 'IF';
'ELSE'              console.log("LEXEMA = "+yytext);return 'ELSE';

/* operators */
"*"               	return '*';
"/"                 return '/';
"-"                 return '-';
"+"                 return '+';
">="                return '>=';
"<="                return '<=';
"<"                 return '<';
">"                 return '>';
"!="                return '!=';
"=="                return '==';
"="                 return '=';

/* other operators */
"("                     return '(';
")"                     return ')';
":"                    	return ':';
";"                 	return ';';
","                   	return ',';
"{"                     return '{';
"}"                     return '}';
"EOF"              	    return 'EOF';
\d+             	    return 'INT';
[a-zA-Z_][a-zA-Z0-9_-]*	return 'ID';

/lex

//Simbolo distinguido de la gramatica
%start program

%% /* parser */

program
    : "BEGINDEC" declaraciones "ENDDEC" "BEGIN" sentencias "END" EOF
        {console.log($1 + $2 + $3 + $4 + $5 + $6);  yy.instance().obtenerTodasLasVariables(); return $1 + $2 + $3 + $4 + $5 + $6;}
    ;

declaraciones
    : declaracion declaraciones
        {console.log('Regla 1.1 declaraciones-> declaracion declaraciones'); $$ = ''.concat($1,$2);}
    | declaracion
        {console.log('Regla 1.2 declaraciones-> declaracion'); $$ = ''.concat($1);}
    ;

declaracion
    : variable_type data_type "ID" ";"
        {console.log('Regla 2.1 declaracion-> variable_type data_type "ID" ";"'); $$ = ''.concat($1,$2,$3,$4); yy.instance().agregarVariable($1,$2,$3,null);}
    | variable_type data_type "ID" ":" value ";"
        {console.log('Regla 2.2 declaracion-> variable_type data_type "ID" ":" value ";"'); $$ = ''.concat($1,$2,$3,$4,$5,$6); yy.instance().agregarVariable($1,$2,$3,$5);}
    ;

variable_type
    : "VAR"
        {console.log('Regla 3.1 variable_type-> VAR'); $$ = ''.concat($1);}
    | "CONST"
        {console.log('Regla 3.2 variable_type-> CONST'); $$ = ''.concat($1);}
    ;

data_type
    : "INTEGER_TYPE"
        {console.log('Regla 4.1 data_type-> INTEGER_TYPE'); $$ = ''.concat($1);}
    | "STRING_TYPE"
        {console.log('Regla 4.2 data_type-> STRING_TYPE'); $$ = ''.concat($1);}
    ;

value
    : "INT"
        {console.log('Regla 5.1 value-> INTEGER'); $$ = +''.concat($1);}
    | "STR"
        {console.log('Regla 5.2 value-> STRING'); $$ = ''.concat($1);}
    ;

sentencias
    : sentencia sentencias
        {console.log('Regla 6.1 sentencias-> sentencia sentencias'); $$ = ''.concat($1,$2);}
    | sentencia
        {console.log('Regla 6.2 sentencias-> sentencia'); $$ = ''.concat($1);}
    ;

sentencia
    : asignacion
        {console.log('Regla 7.1 sentencias-> asignacion'); $$ = ''.concat($1);}
    | condicion_if
        {console.log('Regla 7.2 sentencias-> condicion_if'); $$ = ''.concat($1);}
    | condicion_while
        {console.log('Regla 7.2 sentencias-> condicion_while'); $$ = ''.concat($1);}
    | write
        {console.log('Regla 7.3 sentencias-> write'); $$ = ''.concat($1);}
    ;

write
    : "WRITE" casteo_a_string e ";"
        {console.log('Regla 10.1 write-> "WRITE" casteo_a_string e'); $$ = ''.concat($1,$2,$3,$4); yy.instance().imprimir($3,true);}
    | "WRITE" "STR" ";"
        {console.log('Regla 10.2 write-> "WRITE" "STR" ";"'); $$ = ''.concat($1,$2,$3); yy.instance().imprimir($2,true);}
    | "WRITE" "ID" ";"
        {console.log('Regla 10.3 write-> "WRITE" casteo_a_string "ID" ";"'); $$ = ''.concat($1,$2,$3,); yy.instance().imprimir($2,false);}
    ;

casteo_a_string
    : "(" "STRING_TYPE" ")"
        {console.log('seccion_main-> ( STRING_TYPE )'); $$ = ''.concat($1,$2,$3);}
    ;

asignacion
    : "ID" ":" e ";"
        {console.log('asignacion-> "ID" ":" e ";"'); $$ = ''.concat($1,$2,$3,$4); yy.instance().actualizarVariable($1,$3);}
    | "ID" ":" "STR" ";"
        {console.log('asignacion-> "ID" ":" "STR" ";"'); $$ = ''.concat($1,$2,$3,$4); yy.instance().actualizarVariable($1,$3);}
    ;

condicion_if
    : "IF" "(" comparacion ")" "{" sentencias "}"
        {console.log('Regla 8.1 condicion_if-> "IF" "(" e ")" "{" sentencias "}"'); $$ = ''.concat($1,$2,$3,$4,$5,$6,$7);}
    | "IF" "(" comparacion ")" "{" sentencias "}" "ELSE" "{" sentencias "}"
        {console.log('Regla 8.1 condicion_if-> "IF" "(" e ")" "{" sentencias "}"'); $$ = ''.concat($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11);}
    ;

condicion_while
    : "WHILE" "(" comparacion ")" "{" sentencias "}"
        {console.log('condicion_while-> "WHILE" "(" comparacion ")" "{" sentencias "}"');$$ = ''.concat($1,$2,$3,$4,$5,$6,$7);}
    ;

comparacion
    : e "<=" e
        {console.log('Regla 9.1 comparacion-> e "<=" e'); $$ = $1 <= $3}
    | e ">=" e
        {console.log('Regla 9.2 comparacion-> e ">=" e');  $$ = $1 >= $3;}
    | e "<" e
        {console.log('Regla 9.3 comparacion-> e "<" e');  $$ = $1 < $3;}
    | e ">" e
        {console.log('Regla 9.4 comparacion-> e ">" e');  $$ = $1 > $3;}
    | e "==" e
        {console.log('Regla 9.5 comparacion-> e "==" e');  $$ = $1 == $3;}
    ;
    
e
    : e '+' t
        {console.log('Regla 1.1 e-> e + e'); $$ = $1 + $3;}
    | e '-' t
		{console.log('Regla 1.2 e-> e - e'); $$ = $1 - $3;}
    | t
		{console.log('Regla 1.3 e-> t'); $$ = +yytext;}
    ;

t
    : t '*' f
        {console.log('Regla 1.4 t-> t * f'); $$ = $1 * $3;}
    | t '/' f
		{console.log('Regla 1.5 t-> t / f'); $$ = $1 / $3;}
    | f
		{console.log('Regla 1.6 t-> f'); $$ = +yytext;}
    ;

f
    : '-' f
        {console.log('Regla 1.7 f-> -f'); $$ = - $2;}
    | fs
		{console.log('Regla 1.8 f-> fs'); $$ = +yytext;}
    ;

fs
    : INT
		{console.log('Regla 1.9 fs-> NUMBER'); $$ = +yytext;}
	| ID
		{console.log('Regla 1.10 fs-> ID'); $$ = yy.instance().obtenerVariable($1).valor;}
    | '(' e ')'
		{console.log('Regla 1.6 e-> ( e )'); $$ = ($2);}
    ;
    