/* description: Parses end executes mathematical expressions. *

/* lexer */
%lex
%options flex
%%
\s+                  /* skip whitespace */
\".*\"             	return 'STR';

/* keywords */
'PROGRAM'           console.log("LEXEMA = "+yytext);return 'PROGRAM';
'END'               console.log("LEXEMA = "+yytext);return 'END';
'PRINT'             console.log("LEXEMA = "+yytext);return 'PRINT';
'FUNC'              console.log("LEXEMA = "+yytext);console.log("yy.can_return_value 1", yy.can_return_value);yy.can_return_value=true;return 'FUNC';
'PROC'              console.log("LEXEMA = "+yytext);console.log("yy.can_return_value 2", yy.can_return_value);yy.can_return_value=false;return 'PROC';
'THEN'              console.log("LEXEMA = "+yytext);return 'THEN';
'IS'                console.log("LEXEMA = "+yytext);return 'IS';
'DO'                console.log("LEXEMA = "+yytext);return 'DO';
'BREAK'             console.log("LEXEMA = "+yytext);return 'BREAK';
'CONTINUE'          console.log("LEXEMA = "+yytext);return 'CONTINUE';
'RETURN'            console.log("LEXEMA = "+yytext);return 'RETURN';
'EMPTY_RULE'        console.log("LEXEMA = "+yytext);return 'EMPTY_RULE';

/* variables types */
'VAR'               console.log("LEXEMA = "+yytext);return 'VAR';
'CONST'             console.log("LEXEMA = "+yytext);return 'CONST';

/* data types */
'INTEGER_TYPE'      console.log("LEXEMA = "+yytext);return 'INTEGER_TYPE';
'FLOAT_TYPE'        console.log("LEXEMA = "+yytext);return 'FLOAT_TYPE';
'BOOLEAN_TYPE'      console.log("LEXEMA = "+yytext);return 'BOOLEAN_TYPE';

/* conditional structures */
'WHILE'             console.log("LEXEMA = "+yytext);yy.iterator_counter++;return 'WHILE';
'UNTIL'             console.log("LEXEMA = "+yytext);;yy.iterator_counter++;return 'UNTIL'
'UNLESS'            console.log("LEXEMA = "+yytext);return 'UNLESS';
'IF'                console.log("LEXEMA = "+yytext);return 'IF';
'ELSE'              console.log("LEXEMA = "+yytext);return 'ELSE';

/* arithmetic operators */
'+'                 console.log("LEXEMA = "+yytext);return '+';
'-'                 console.log("LEXEMA = "+yytext);return '-';
'*'                 console.log("LEXEMA = "+yytext);return '*';
'/'                 console.log("LEXEMA = "+yytext);return '/';

/* comparison operators */
'=='                console.log("LEXEMA = "+yytext);return '==';
'<>'                console.log("LEXEMA = "+yytext);return '<>';
'>'                 console.log("LEXEMA = "+yytext);return '>';
'<'                 console.log("LEXEMA = "+yytext);return '<';
'<='                console.log("LEXEMA = "+yytext);return '<=';
'>='                console.log("LEXEMA = "+yytext);return '>=';

/* logic operators */
'&&'                console.log("LEXEMA = "+yytext);return '&&';
'||'                console.log("LEXEMA = "+yytext);return '||';
'!'                 console.log("LEXEMA = "+yytext);return '!';

/* other operators */
':'                 console.log("LEXEMA = "+yytext);return ':';
';'                 console.log("LEXEMA = "+yytext);return ';';
','                 console.log("LEXEMA = "+yytext);return ',';
'<-'                console.log("LEXEMA = "+yytext);return '<-';
'('                 console.log("LEXEMA = "+yytext);return '(';
')'                 console.log("LEXEMA = "+yytext);return ')';

/* other values */
"EOF"              	        return 'EOF';
\d+\.\d+|\.\d+|\d+\.        return 'FLOAT';
\d+             	        return 'INT';
[a-zA-Z_][a-zA-Z0-9_]*\??   return 'ID'
true                        return 'TRUE'
false                       return 'FALSE'

/lex

//Simbolo distinguido de la gramatica
%start program

%% /* parser */

program
    : "PROGRAM" ID definiciones EOF
        {console.log($1 + $2 + $3 + $4);$$ = ' '.concat($1,$2,$3,$4); return $$;}
    ;

definiciones
     : definicion definiciones
        {console.log('Regla 1.1 definiciones-> definicion definiciones'); $$ = ' '.concat($1,$2);}
    | definicion
        {console.log('Regla 1.2 definiciones-> definicion'); $$ = ' '.concat($1);}
    ;

definicion
    : def_variable ';'
        {console.log('Regla 2.1 definicion-> def_variable;'); $$ = ' '.concat($1,$2);}
    | def_funcion
        {console.log('Regla 2.2 definicion-> def_funcion'); $$ = ' '.concat($1);}
    | def_procedimiento
        {console.log('Regla 2.3 definicion-> def_procedimiento'); $$ = ' '.concat($1);}
    ;

data_type
    : INTEGER_TYPE
        {console.log('Regla 3.1 data_type-> INTEGER_TYPE'); $$ = ' '.concat($1);}
    | BOOLEAN_TYPE
        {console.log('Regla 3.2 data_type-> BOOLEAN_TYPE'); $$ = ' '.concat($1);}
    | FLOAT_TYPE
        {console.log('Regla 3.3 data_type-> FLOAT_TYPE'); $$ = ' '.concat($1);}
    ;

def_variable
    : VAR ID ":" data_type
        {console.log('Regla 4.1 def_variable-> VAR ID : data_type'); $$ = ' '.concat($1,$2,$3,$4);}
    | VAR ID ":" data_type "<-" e
        {console.log('Regla 4.2 def_variable-> VAR ID : data_type <- e'); $$ = ' '.concat($1,$2,$3,$4,$5,$6);}
    | CONST ID ":" data_type "<-" e
        {console.log('Regla 4.3 def_variable-> CONST ID : data_type <- e'); $$ = ' '.concat($1,$2,$3,$4,$5,$6);}
    ;

def_funcion
    : FUNC ID '(' parametros_definicion ')' ':' data_type IS sentencias END
        {console.log('Regla 5.1 def_funcion-> FUNC ID ( parametros ) : data_type IS sentencias END'); $$ = ' '.concat($1,$2,$3,$4,$5,$6,$7,$8,$9,$10);}
    | FUNC ID '('  ')' ":" data_type IS sentencias END
        {console.log('Regla 5.2 def_funcion-> FUNC ID ( ) : data_type IS sentencias END'); $$ = ' '.concat($1,$2,$3,$4,$5,$6,$7,$8,$9,);}
    ;

def_procedimiento
    : PROC ID '(' parametros_definicion ')' IS sentencias END
        {console.log('Regla 6.1 def_procedimiento-> PROC ID ( parametros ) IS sentencias END'); $$ = ' '.concat($1,$2,$3,$4,$5,$6,$7,$8);}
    | PROC ID '('  ')' IS sentencias END
        {console.log('Regla 6.2 def_procedimiento-> PROC ID (  ) IS sentencias END'); $$ = ' '.concat($1,$2,$3,$4,$5,$6,$7);}
    ;

parametros_definicion
    : parametro_definicion ',' parametros_definicion
        {console.log('Regla 7.1 parametros_definicion-> parametro_definicion , parametros_definicion'); $$ = ' '.concat($1,$2,$3);}
    | parametro_definicion
        {console.log('Regla 7.2 parametros_definicion-> parametro_definicion'); $$ = ' '.concat($1);}
    ;

parametro_definicion
    : ID ":" data_type 
        {console.log('Regla 8.1 parametro_definicion-> ID : data_type '); $$ = ' '.concat($1,$2,$3);}
    ;

sentencias
    : sentencia ';' sentencias  
        {console.log('Regla 9.1 sentencias-> sentencia ; sentencias'); $$ = ' '.concat($1,$2,$3);}
    | sentencia ';'
        {console.log('Regla 9.2 sentencias-> sentencia;'); $$ = ' '.concat($1,$2);}
    ;

sentencia
    : condicion_while
        {console.log('Regla 10.1 sentencia-> condicion_while'); $$ = ' '.concat($1);}
    | condicion_until
        {console.log('Regla 10.2 sentencia-> condicion_until'); $$ = ' '.concat($1);}
    | def_variable
        {console.log('Regla 10.3 sentencia-> def_variable'); $$ = ' '.concat($1);}
    | condicion_if
        {console.log('Regla 10.4 sentencia-> condicion_if'); $$ = ' '.concat($1);}
    | sentencia_una_linea
        {console.log('Regla 10.5 sentencia-> sentencia_una_linea'); $$ = ' '.concat($1);}
    ;

sentencia_una_linea
    : ID "<-" e
        {console.log('Regla 12.1 sentencia_una_linea-> ID <- e'); $$ = ' '.concat($1,$2,$3);}
    | RETURN e 
        {console.log('Regla 12.2 sentencia_una_linea-> return e'); $$ = ' '.concat($1,$2); if(yy.can_return_value === false)throw new Error("Procs cant return anything");}
    | RETURN 
        {console.log('Regla 12.3 sentencia_una_linea-> return'); $$ = ' '.concat($1); if(yy.can_return_value === true)throw new Error("Function does not return anything");}
    | BREAK
        {console.log('Regla 12.4 sentencia_una_linea-> break'); $$ = ' '.concat($1);if(yy.iterator_counter === 0)throw new Error("Can't use break outside a control structure");}
    | CONTINUE
        {console.log('Regla 12.5 sentencia_una_linea-> continue'); $$ = ' '.concat($1); if(yy.iterator_counter === 0)throw new Error("Can't use continue outside a control structure");}
    | call_proc
        {console.log('Regla 12.6 sentencia_una_linea-> call_proc'); $$ = ' '.concat($1);}
    | print
        {console.log('Regla 12.7 sentencia_una_linea-> print'); $$ = ' '.concat($1);}
    ;

condicion_if
    : IF e THEN sentencias END
        {console.log('Regla 13.1 condicion_if-> IF e THEN sentencias END'); $$ = ' '.concat($1,$2,$3,$4,$5);}
    | IF e THEN sentencias ELSE sentencias END
        {console.log('Regla 13.2 condicion_if-> IF e THEN sentencias ELSE sentencias END'); $$ = ' '.concat($1,$2,$3,$4,$5,$6,$7);}
    | sentencia_una_linea IF e ';'
    ;

condicion_unless
    : UNLESS e DO sentencias END
        {console.log('Regla 14.1 condicion_unless-> UNLESS e DO sentencias END'); $$ = ' '.concat($1,$2,$3,$4,$5);}
    | UNLESS e DO sentencias ELSE sentencias END
        {console.log('Regla 14.2 condicion_unless-> UNLESS e DO sentencias ELSE sentencias END'); $$ = ' '.concat($1,$2,$3,$4,$5,$6,$7);}
    | UNLESS e
        {console.log('Regla 15.3 condicion_unless-> sentencia_una_linea UNLESS e'); $$ = ' '.concat($1,$2);}
    ;

condicion_while
    : WHILE e DO sentencias END
        {console.log('Regla 16.1 condicion_while-> WHILE e DO sentencias END'); $$ = ' '.concat($1,$2,$3,$4,$5); yy.iterator_counter--;}
    ;

condicion_until
    : UNTIL e DO sentencias END
        {console.log('Regla 17.1 condicion_until-> UNTIL e DO sentencias END'); $$ = ' '.concat($1,$2,$3,$4,$5); yy.iterator_counter--;}
    ;

print
    : PRINT STR
        {console.log('Regla 18.1 print-> PRINT STR'); $$ = ' '.concat($1,$2);}
    | PRINT e
        {console.log('Regla 18.2 print-> PRINT e'); $$ = ' '.concat($1,$2);}
    ;

call_function
    : ID '(' parametros_llamada ')'
        {console.log('Regla 19.1 call_function-> ID ( parametros_llamada )'); $$ = ' '.concat($1,$2,$3,$4); }
    | ID '(' ')'
        {console.log('Regla 19.2 call_function-> ID ( )'); $$ = ' '.concat($1,$2,$3);}
    ;

call_proc
    : ID '(' parametros_llamada ')'
        {console.log('Regla 20.1 call_proc-> ID ( parametros_llamada )'); $$ = ' '.concat($1,$2,$3,$4);}
    | ID '(' ')'
        {console.log('Regla 20.2 call_proc-> ID ( )'); $$ = ' '.concat($1,$2,$3);}
    ;

parametros_llamada
    : e ',' parametros_llamada
        {console.log('Regla 21.1 parametros_llamada-> e , parametros_llamada'); $$ = ' '.concat($1,$2,$3);}
    | e
        {console.log('Regla 22.2 parametros_llamada-> e'); $$ = ' '.concat($1);}
    ;
    
e 
    : e '||' ela
        {console.log('Regla 23.1 e-> ela || el');$$ = ' '.concat($1,$2,$3);}
    | ela
        {console.log('Regla 23.2 e-> ela');$$ = ' '.concat($1);}
    | ea
        {console.log('Regla 23.3 e-> ea');$$ = ' '.concat($1);}
    ;

ela
    : ela '&&' eld
        {console.log('Regla 24.1 ela-> ela && eld'); $$ = ' '.concat($1,$2,$3);}
    | eld
        {console.log('Regla 24.2 ela-> eld');$$ = ' '.concat($1);}
    ;

eld
    : '!' eld
        {console.log('Regla 25.1 eld-> ! eld'); $$ = ' '.concat($1,$2);}
    | comparacion
        {console.log('Regla 25.2 eld-> comparacion'); $$ = ' '.concat($1);}
    ;

comparacion
    : ea "<=" ea
        {console.log('Regla 26.1 comparacion-> e "<=" e'); ' '.concat($1,$2,$3);}
    | ea ">=" ea
        {console.log('Regla 26.2 comparacion-> e ">=" e'); ' '.concat($1,$2,$3);}
    | ea "<" ea
        {console.log('Regla 26.3 comparacion-> e "<" e'); ' '.concat($1,$2,$3);}
    | ea ">" ea
        {console.log('Regla 26.4 comparacion-> e ">" e'); ' '.concat($1,$2,$3);}
    | ea "==" ea
        {console.log('Regla 26.5 comparacion-> e "==" e'); ' '.concat($1,$2,$3);}
    | ea "<>" ea
        {console.log('Regla 26.5 comparacion-> e "==" e'); ' '.concat($1,$2,$3);}
    | 'TRUE'
        {console.log('Regla 26.6 comparacion-> true'); $$ = ' '.concat($1);}
    | 'FALSE'
        {console.log('Regla 26.7 comparacion-> false'); $$ = ' '.concat($1);}
    ;

ea
    : ea '+' t
        {console.log('Regla 27.1 ea-> ea + t'); ' '.concat($1,$2,$3);}
    | ea '-' t
		{console.log('Regla 27.2 ea-> ea - t'); ' '.concat($1,$2,$3);}
    | t
		{console.log('Regla 27.3 e-> t'); ' '.concat($1);}
    ;

t
    : t '*' f
        {console.log('Regla 28.1 t-> t * f'); ' '.concat($1,$2,$3);}
    | t '/' f
		{console.log('Regla 28.2 t-> t / f'); ' '.concat($1,$2,$3);}
    | f
		{console.log('Regla 28.3 t-> f'); ' '.concat($1);}
    ;

f
    : '-' f
        {console.log('Regla 29.1 f-> -f'); ' '.concat($1,$2);}
    | fs
		{console.log('Regla 29.2 f-> fs'); ' '.concat($1);}
    ;

fs
    : INT
		{console.log('Regla 30.1 fs-> NUMBER'); ' '.concat($1);}
	| id_or_functionCall
		{console.log('Regla 30.2 fs-> id_or_functionCall'); ' '.concat($1);}
    | FLOAT
        {console.log('Regla 30.3 fs-> FLOAT'); ' '.concat($1);}
    | '(' e ')'
		{console.log('Regla 30.4 e-> ( e )'); ' '.concat($1,$2,$3);}
    ;

id_or_functionCall
    : call_function
        {console.log('Regla 31.1 id_or_functionCall-> call_function'); ' '.concat($1);}
    | ID 
        {console.log('Regla 31.2 id_or_functionCall-> ID'); ' '.concat($1);}
    ;
    