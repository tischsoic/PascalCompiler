package grammar;

import java_cup.runtime.Symbol;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;

%%
%public
%class Lexer
%cup
%implements sym
%char
%line
%column
%caseless


%{
    StringBuffer string = new StringBuffer();
    public Lexer(java.io.Reader in, ComplexSymbolFactory sf, String inputFile){
	this(in);
	symbolFactory = sf;
	inputFileName = inputFile;
    }
    ComplexSymbolFactory symbolFactory;
    String inputFileName;

  private Symbol symbol(String name, int sym) {
      return symbolFactory.newSymbol(name, sym, new Location(inputFileName, yyline+1,yycolumn+1,yychar), new Location(inputFileName, yyline+1,yycolumn+yylength(),yychar+yylength()));
  }

    private Symbol symbol(int sym) {
    String name = terminalNames[sym];
        return symbolFactory.newSymbol(name, sym, new Location(inputFileName, yyline+1,yycolumn+1,yychar), new Location(inputFileName, yyline+1,yycolumn+yylength(),yychar+yylength()));
    }

  private Symbol symbol(String name, int sym, Object val) {
      Location left = new Location(inputFileName, yyline+1,yycolumn+1,yychar);
      Location right= new Location(inputFileName, yyline+1,yycolumn+yylength(), yychar+yylength());
      return symbolFactory.newSymbol(name, sym, left, right,val);
  }
  private Symbol symbol(String name, int sym, Object val,int buflength) {
      Location left = new Location(inputFileName, yyline+1,yycolumn+yylength()-buflength,yychar+yylength()-buflength);
      Location right= new Location(inputFileName, yyline+1,yycolumn+yylength(), yychar+yylength());
      return symbolFactory.newSymbol(name, sym, left, right,val);
  }
  private void error(String message) {
    System.out.println("Error at line "+(yyline+1)+", column "+(yycolumn+1)+" : "+message);
  }
%}

%eofval{
     return symbolFactory.newSymbol("EOF", EOF, new Location(inputFileName, yyline+1,yycolumn+1,yychar), new Location(inputFileName, yyline+1,yycolumn+1,yychar+1));
%eofval}

SpaceChar		=	[\ \t]
LineChar		=	\n|\r|\r\n;

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

%state STRING

%%

<YYINITIAL>{
and				{ return symbol( AND ); }
array			{ return symbol( ARRAY ); }
begin			{ return symbol( BEGIN ); }
case			{ return symbol( CASE ); }
const			{ return symbol( CONST ); }
div				{ return symbol( DIV ); }
do				{ return symbol( DO ); }
downto			{ return symbol( DOWNTO ); }
else			{ return symbol( ELSE ); }
end				{ return symbol( END ); }
file			{ return symbol( FILE ); }
for				{ return symbol( FOR ); }
function		{ return symbol( FUNCTION ); }
goto			{ return symbol( GOTO ); }
if				{ return symbol( IF ); }
in				{ return symbol( IN ); }
label			{ return symbol( LABEL ); }
mod				{ return symbol( MOD ); }
nil				{ return symbol( NIL ); }
not				{ return symbol( NOT ); }
of				{ return symbol( OF ); }
or				{ return symbol( OR ); }
packed			{ return symbol( PACKED ); }
procedure		{ return symbol( PROCEDURE ); }
program			{ return symbol( PROGRAM ); }
record			{ return symbol( RECORD ); }
repeat			{ return symbol( REPEAT ); }
set				{ return symbol( SET ); }
then			{ return symbol( THEN ); }
to				{ return symbol( TO ); }
type			{ return symbol( TYPE ); }
until			{ return symbol( UNTIL ); }
var				{ return symbol( VAR ); }
while			{ return symbol( WHILE ); }
with			{ return symbol( WITH ); }
read			{ return symbol( READ ); }
readln			{ return symbol( READLN ); }
write			{ return symbol( WRITE ); }
writeln			{ return symbol( WRITELN ); }
uses            { return symbol( USES );}

"("				{ return symbol( LEFT ); }
")"				{ return symbol( RIGHT ); }
"["				{ return symbol( LEFTSQ ); }
"]"				{ return symbol( RIGHTSQ ); }

":"				{ return symbol( COLON ); }
";"				{ return symbol( SEMICOLON ); }
","				{ return symbol( COMMA ); }
"."				{ return symbol( DOT ); }
".."			{ return symbol( DOTDOT ); }
"^"				{ return symbol( PTR ); }

":="			{ return symbol( ASSIGN ); }

"+"				{ return symbol( PLUS ); }
"-"				{ return symbol( MINUS ); }
"*"				{ return symbol( TIMES ); }
"/"				{ return symbol( DIVIDE ); }

"="				{ return symbol( EQ ); }
"<>"			{ return symbol( NE ); }
"<"				{ return symbol( LT ); }
">"				{ return symbol( GT ); }
"<="			{ return symbol( LE ); }
">="			{ return symbol( GE ); }

true			{ return symbol( "Boolean", BOOLCONST, Boolean.parseBoolean(yytext()) ); }
false			{ return symbol( "Boolean", BOOLCONST, Boolean.parseBoolean(yytext()) ); }

{Integer}		{ return symbol( "Integer", INTCONST, Integer.parseInt(yytext()) ); }

{Float}			{ return symbol( "Float", REALCONST, Double.parseDouble(yytext()) ); }

\'{Char}\'		{ return symbol( "Char", CHARCONST, yytext().charAt(0) ); }
\'{Char}*\'		{ return symbol( "String", STRINGCONST, yytext() ); }

{Ident}			{ return symbol( "Identifier", IDENT, yytext() ); }

"(*"~"*)"		{ }
"{"~"}"			{ }

{LineChar}		{ }
{SpaceChar}		{ }
.				{ return symbol( error ); }
<<EOF>>			{ return symbol( EOF ); }

}
