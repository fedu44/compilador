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
'program'           yy.lastToken=""; return 'PROGRAM';
'end'               yy.lastToken="END"; return 'END';
'print'             yy.lastToken=""; return 'PRINT';
'func'              yy.lastToken=""; return 'FUNC';
'proc'              yy.lastToken=""; return 'PROC';
'then'              yy.lastToken="THEN"; return 'THEN';
'is'                yy.lastToken="IS"; return 'IS';
'do'                yy.lastToken="DO"; return 'DO';
'break'             return 'BREAK';
'continue'          return 'CONTINUE';
'return'            yy.lastToken="RETURN"; return 'RETURN';

/* variables types */
'var'               yy.lastToken=""; return 'VAR';
'const'             yy.lastToken=""; return 'CONST';

/* data types */
'int'               yy.lastToken="";return 'INTEGER_TYPE';
'float'             yy.lastToken="";return 'FLOAT_TYPE';
'bool'              yy.lastToken="";return 'BOOLEAN_TYPE';

/* conditional structures */
'while'             yy.lastToken=""; return 'WHILE';
'until'             yy.lastToken=""; return 'UNTIL';
'unless'            yy.lastToken="UNLESS"; return 'UNLESS';
'if'                yy.lastToken="IF"; return 'IF';
'else'              yy.lastToken=""; return 'ELSE';

/* identifiers */
{IDENTIFIER}		yy.lastToken=""; return yytext;

/* literals */
true|false          yy.lastToken=""; return yytext;
\d+\.\d+		    yy.lastToken=""; return yytext;
\d+\.		        yy.lastToken=""; return yytext;
\.\d+		        yy.lastToken=""; return yytext;
\d+		            yy.lastToken=""; return yytext;
'"'					yy.text=yytext; this.begin('cadena');
'/*'                yy.text="";yy.commentNest = 1; this.begin('comment');

/* arithmetic operators */
'+'                 yy.lastToken=""; return '+';
'-'                 yy.lastToken=""; return '-';
'*'                 yy.lastToken=""; return '*';
'/'                 yy.lastToken=""; return '/';

/* comparison operators */
'=='                yy.lastToken=""; return '==';
'<>'                yy.lastToken=""; return '<>';
'>'                 yy.lastToken=""; return '>';
'<'                 yy.lastToken=""; return '<';
'<='                yy.lastToken=""; return '<=';
'>='                yy.lastToken=""; return '>=';

/* logic operators */
'&&'                yy.lastToken=""; return '&&';
'||'                yy.lastToken=""; return '||';
'!'                 yy.lastToken=""; return '!';

/* other operators */
':'                 yy.lastToken=""; return ':';
','                 yy.lastToken=""; return ',';
'<-'                yy.lastToken=""; return '<-';
'('                 yy.lastToken=""; return '(';
')'                 yy.lastToken=""; return ')';

/* errors */
'*/'                throw new Error("Not open /*");

/* ignore */
{ENDOFLINECOMMENT}	    /* ignore */
{WHITESPACE}		    /* ignore */
{LINETERMINATOR}    {if(!['END','THEN','IS','DO','INITIAL'].includes(yy.lastToken)){return ';\n'}};

<cadena>'"'				this.begin('INITIAL'); return yy.text+yytext;
<cadena>[^\n\"\\]+	    yy.text=yy.text+yytext;
<cadena>\\t             yy.text=yy.text+yytext;
<cadena>\\n             yy.text=yy.text+yytext;
<cadena>\\\"            yy.text=yy.text+yytext;
<cadena>\\             	yy.text=yy.text+yytext;
<*><<EOF>>              return 'EOF';

<comment>(.*?(?=\/\*)|.*?(?=\*\/))	    yy.text=yy.text+yytext;	
<comment>\*\/	                        yy.commentNest = yy.commentNest - 1; yy.text=yy.text+yytext; if(yy.commentNest === 0){ this.begin('INITIAL');};
<comment>\/\*	                        yy.commentNest = yy.commentNest + 1;  yy.text=yy.text+yytext; 
<*><<EOF>>                              return 'EOF';
%%	