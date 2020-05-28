%options flex
LINETERMINATOR			\r|\n|\r\n
INPUTCHARACTER 			[^\r\n]
WHITESPACE				[ \t\f]
%options flex
/* comments */
// Comment can be the last line of the file, without line terminator.
ENDOFLINECOMMENT		'//'{INPUTCHARACTER}*{LINETERMINATOR}?

IDENTIFIER				[a-zA-Z_][a-zA-Z0-9_]*\??

%x cadena
%x comment

%%

/* keywords */
'program'           console.log("LEXEMA = "+yytext);yy.lastToken="";return 'PROGRAM';
'end'               console.log("LEXEMA = "+yytext);yy.lastToken="END";return 'END';
'print'             console.log("LEXEMA = "+yytext);yy.lastToken="";return 'PRINT';
'func'              console.log("LEXEMA = "+yytext);yy.lastToken="";return 'FUNC';
'proc'              console.log("LEXEMA = "+yytext);yy.lastToken="";return 'PROC';
'then'              console.log("LEXEMA = "+yytext);yy.lastToken="THEN";return 'THEN';
'is'                console.log("LEXEMA = "+yytext);yy.lastToken="IS";return 'IS';
'do'                console.log("LEXEMA = "+yytext);yy.lastToken="DO";return 'DO';
'break'             console.log("LEXEMA = "+yytext);return 'BREAK';
'continue'          console.log("LEXEMA = "+yytext);return 'CONTINUE';
'return'            console.log("LEXEMA = "+yytext);yy.lastToken="RETURN";return 'RETURN';

/* variables types */
'var'               console.log("LEXEMA = "+yytext);yy.lastToken="";return 'VAR';
'const'             console.log("LEXEMA = "+yytext);yy.lastToken="";return 'CONST';

/* data types */
'int'               console.log("LEXEMA = "+yytext);yy.lastToken="";return 'INTEGER_TYPE';
'float'             console.log("LEXEMA = "+yytext);yy.lastToken="";return 'FLOAT_TYPE';
'bool'              console.log("LEXEMA = "+yytext);yy.lastToken="";return 'BOOLEAN_TYPE';

/* conditional structures */
'while'             console.log("LEXEMA = "+yytext);yy.lastToken="";return 'WHILE';
'until'             console.log("LEXEMA = "+yytext);yy.lastToken="";return 'UNTIL';
'unless'            console.log("LEXEMA = "+yytext);yy.lastToken="UNLESS";return 'UNLESS';
'if'                console.log("LEXEMA = "+yytext);yy.lastToken="IF";return 'IF';
'else'              console.log("LEXEMA = "+yytext);yy.lastToken="";return 'ELSE';

/* identifiers */
{IDENTIFIER}		console.log("LEXEMA = "+yytext);yy.lastToken="";return yytext;

/* literals */
true|false          console.log("LEXEMA = "+yytext);yy.lastToken="";return yytext;
\d+\.\d+		    console.log("LEXEMA = "+yytext);yy.lastToken="";return yytext;
\d+\.		        console.log("LEXEMA = "+yytext);yy.lastToken="";return yytext;
\.\d+		        console.log("LEXEMA = "+yytext);yy.lastToken="";return yytext;
\d+		            console.log("LEXEMA = "+yytext);yy.lastToken="";return yytext;
'"'					yy.text=yytext; this.begin('cadena');
'/*'                yy.text="";yy.commentNest = 1; this.begin('comment');

/* arithmetic operators */
'+'                 console.log("LEXEMA = "+yytext);yy.lastToken="";return '+';
'-'                 console.log("LEXEMA = "+yytext);yy.lastToken="";return '-';
'*'                 console.log("LEXEMA = "+yytext);yy.lastToken="";return '*';
'/'                 console.log("LEXEMA = "+yytext);yy.lastToken="";return '/';

/* comparison operators */
'=='                console.log("LEXEMA = "+yytext);yy.lastToken="";return '==';
'<>'                console.log("LEXEMA = "+yytext);yy.lastToken="";return '<>';
'>'                 console.log("LEXEMA = "+yytext);yy.lastToken="";return '>';
'<'                 console.log("LEXEMA = "+yytext);yy.lastToken="";return '<';
'<='                console.log("LEXEMA = "+yytext);yy.lastToken="";return '<=';
'>='                console.log("LEXEMA = "+yytext);yy.lastToken="";return '>=';

/* logic operators */
'&&'                console.log("LEXEMA = "+yytext);yy.lastToken="";return '&&';
'||'                console.log("LEXEMA = "+yytext);yy.lastToken="";return '||';
'!'                 console.log("LEXEMA = "+yytext);yy.lastToken="";return '!';

/* other operators */
':'                 console.log("LEXEMA = "+yytext);yy.lastToken="";return ':';
','                 console.log("LEXEMA = "+yytext);yy.lastToken="";return ',';
'<-'                console.log("LEXEMA = "+yytext);yy.lastToken="";return '<-';
'('                 console.log("LEXEMA = "+yytext);yy.lastToken="";return '(';
')'                 console.log("LEXEMA = "+yytext);yy.lastToken="";return ')';

/* errors */
'*/'                throw new Error("Not open /*");

/* ignore */
{ENDOFLINECOMMENT}	    /* ignore */
{WHITESPACE}		    /* ignore */
{LINETERMINATOR}    console.log("yy.lastToken", yy.lastToken);{if(!['END','THEN','IS','DO','INITIAL'].includes(yy.lastToken)){return ';\n'}};

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