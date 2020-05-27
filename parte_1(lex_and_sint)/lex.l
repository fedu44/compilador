%options flex
LINETERMINATOR			\r|\n|\r\n
INPUTCHARACTER 			[^\r\n]
WHITESPACE				{LINETERMINATOR}|[ \t\f]

/* comments */
// Comment can be the last line of the file, without line terminator.
ENDOFLINECOMMENT		'//'{INPUTCHARACTER}*{LINETERMINATOR}?

IDENTIFIER				[a-zA-Z_][a-zA-Z0-9_]*\??

%x cadena
%x comment

%%

/* keywords */
'program'           console.log("LEXEMA = "+yytext);return 'PROGRAM';
'end'               console.log("LEXEMA = "+yytext);return 'END';
'print'             console.log("LEXEMA = "+yytext);return 'PRINT';
'func'              console.log("LEXEMA = "+yytext);return 'FUNC';
'proc'              console.log("LEXEMA = "+yytext);return 'PROC';
'then'              console.log("LEXEMA = "+yytext);return 'THEN';
'is'                console.log("LEXEMA = "+yytext);return 'IS';
'do'                console.log("LEXEMA = "+yytext);return 'DO';
'break'             console.log("LEXEMA = "+yytext);return 'BREAK';
'continue'          console.log("LEXEMA = "+yytext);return 'CONTINUE';
'return'            console.log("LEXEMA = "+yytext);return 'RETURN';

/* variables types */
'var'               console.log("LEXEMA = "+yytext);return 'VAR';
'const'             console.log("LEXEMA = "+yytext);return 'CONST';

/* data types */
'int'               console.log("LEXEMA = "+yytext);return 'INTEGER_TYPE';
'float'             console.log("LEXEMA = "+yytext);return 'FLOAT_TYPE';
'bool'              console.log("LEXEMA = "+yytext);return 'BOOLEAN_TYPE';

/* conditional structures */
'while'             console.log("LEXEMA = "+yytext);return 'WHILE';
'until'             console.log("LEXEMA = "+yytext);return 'UNTIL';
'unless'            console.log("LEXEMA = "+yytext);return 'UNLESS';
'if'                console.log("LEXEMA = "+yytext);return 'IF';
'else'              console.log("LEXEMA = "+yytext);return 'ELSE';

/* identifiers */
{IDENTIFIER}		console.log("LEXEMA = "+yytext);return yytext;

/* literals */
true|false          console.log("LEXEMA = "+yytext);return yytext;
\d+\.\d+		    console.log("LEXEMA = "+yytext);return yytext;
\d+\.		        console.log("LEXEMA = "+yytext);return yytext;
\.\d+		        console.log("LEXEMA = "+yytext);return yytext;
\d+		            console.log("LEXEMA = "+yytext);return yytext;
'"'					yy.text=yytext; this.begin('cadena');
'/*'                yy.text="";yy.commentNest = 1; this.begin('comment');

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

/* comparison operators */
'&&'                console.log("LEXEMA = "+yytext);return '&&';
'||'                console.log("LEXEMA = "+yytext);return '||';
'!'                 console.log("LEXEMA = "+yytext);return '!';

/* other operators */
':'                 console.log("LEXEMA = "+yytext);return ':';
':='                console.log("LEXEMA = "+yytext);return ':=';
'<-'                console.log("LEXEMA = "+yytext);return '<-';
'('                 console.log("LEXEMA = "+yytext);return '(';
')'                 console.log("LEXEMA = "+yytext);return ')';

/* errors */
'*/'                throw new Error("Not open /*");

/* ignore */
{ENDOFLINECOMMENT}	    /* ignore */
{WHITESPACE}		    /* ignore */

<cadena>'"'				this.begin('INITIAL'); console.log("LEXEMA="+yy.text+yytext); return yy.text+yytext;
<cadena>[^\n\"\\]+	    yy.text=yy.text+yytext;
<cadena>\\t             yy.text=yy.text+yytext;
<cadena>\\n             yy.text=yy.text+yytext;
<cadena>\\\"            yy.text=yy.text+yytext;
<cadena>\\             	yy.text=yy.text+yytext;
<*><<EOF>>              return 'EOF';

<comment>(.*?(?=\/\*)|.*?(?=\*\/))	    yy.text=yy.text+yytext;	
<comment>\*\/	                        yy.commentNest = yy.commentNest - 1; console.log("commentNest - : ", yy.commentNest); yy.text=yy.text+yytext; if(yy.commentNest === 0){ this.begin('INITIAL');};
<comment>\/\*	                        yy.commentNest = yy.commentNest + 1; console.log("commentNest + : ", yy.commentNest); yy.text=yy.text+yytext; 
<*><<EOF>>                              return 'EOF';
%%	