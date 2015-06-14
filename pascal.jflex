package grammar;

import java.io.*;
import java_cup.runtime.*;

%%

%public
%type Symbol
%char

%{
	private int lineNumber = 1;
	public int lineNumber() { return lineNumber; }
	
	public Symbol token( int tokenType ) {
		System.err.println( "Obtain token " + sym.terminal_name( tokenType ) 
			+ " \"" + yytext() + "\"" );
		return new Symbol( tokenType, yychar, yychar + yytext().length(), yytext() );
	}

%}

SpaceChar		=	[\ \t]
LineChar		=	\n|\r|\r\n

Zero			=	0
DecInt			=	[1-9][0-9]*
OctalInt		=	0[0-7]+
HexInt			=	0[xX][0-9a-fA-F]+

Integer			=	( {Zero} | {DecInt} | {OctalInt} | {HexInt} )[lL]?
Exponent		=	[eE] [\+\-]? [0-9]+
Float1			=	[0-9]+ \. [0-9]+ {Exponent}?
Float2			=	\. [0-9]+ {Exponent}?
Float3			=	[0-9]+ \. {Exponent}?
Float4			=	[0-9]+ {Exponent}
Float			=	( {Float1} | {Float2} | {Float3} | {Float4} ) [fFdD]? | [0-9]+ [fFDd]
Ident			=	[A-Za-z_$] [A-Za-z_$0-9]*
Char			=	[^\'] | \'\'

%%
and				{ return token( sym.AND ); }
array			{ return token( sym.ARRAY ); }
begin			{ return token( sym.BEGIN ); }
case			{ return token( sym.CASE ); }
const			{ return token( sym.CONST ); }
div				{ return token( sym.DIV ); }
do				{ return token( sym.DO ); }
downto			{ return token( sym.DOWNTO ); }
else			{ return token( sym.ELSE ); }
end				{ return token( sym.END ); }
file			{ return token( sym.FILE ); }
for				{ return token( sym.FOR ); }
function		{ return token( sym.FUNCTION ); }
goto			{ return token( sym.GOTO ); }
if				{ return token( sym.IF ); }
in				{ return token( sym.IN ); }
label			{ return token( sym.LABEL ); }
mod				{ return token( sym.MOD ); }
nil				{ return token( sym.NIL ); }
not				{ return token( sym.NOT ); }
of				{ return token( sym.OF ); }
or				{ return token( sym.OR ); }
packed			{ return token( sym.PACKED ); }
procedure		{ return token( sym.PROCEDURE ); }
program			{ return token( sym.PROGRAM ); }
record			{ return token( sym.RECORD ); }
repeat			{ return token( sym.REPEAT ); }
set				{ return token( sym.SET ); }
then			{ return token( sym.THEN ); }
to				{ return token( sym.TO ); }
type			{ return token( sym.TYPE ); }
until			{ return token( sym.UNTIL ); }
var				{ return token( sym.VAR ); }
while			{ return token( sym.WHILE ); }
with			{ return token( sym.WITH ); }
read			{ return token( sym.READ ); }
readln			{ return token( sym.READLN ); }
write			{ return token( sym.WRITE ); }
writeln			{ return token( sym.WRITELN ); }

"("				{ return token( sym.LEFT ); }
")"				{ return token( sym.RIGHT ); }
"["				{ return token( sym.LEFTSQ ); }
"]"				{ return token( sym.RIGHTSQ ); }

":"				{ return token( sym.COLON ); }
";"				{ return token( sym.SEMICOLON ); }
","				{ return token( sym.COMMA ); }
"."				{ return token( sym.DOT ); }
".."			{ return token( sym.DOTDOT ); }
"^"				{ return token( sym.PTR ); }

":="				{ return token( sym.ASSIGN ); }

"+"				{ return token( sym.PLUS ); }
"-"				{ return token( sym.MINUS ); }
"*"				{ return token( sym.TIMES ); }
"/"				{ return token( sym.DIVIDE ); }

"="				{ return token( sym.EQ ); }
"<>"			{ return token( sym.NE ); }
"<"				{ return token( sym.LT ); }
">"				{ return token( sym.GT ); }
"<="			{ return token( sym.LE ); }
">="			{ return token( sym.GE ); }

true			{ return token( sym.BOOLCONST ); }
false			{ return token( sym.BOOLCONST ); }

{Integer}		{ return token( sym.INTCONST ); }

{Float}			{ return token( sym.REALCONST ); }

\'{Char}\'		{ return token( sym.CHARCONST ); }
\'{Char}*\'		{return token( sym.STRINGCONST ); }

{Ident}			{ return token( sym.IDENT ); }

"(*"~"*)"		{ }
"{"~"}"			{ }

{LineChar}		{ lineNumber++; }
{SpaceChar}		{ }
.				{ return token( sym.error ); }
<<EOF>>			{ return token( sym.EOF ); }

