lexer grammar pascal;

  AND              : 'and'             ;
  ARRAY            : 'array'           ;
  BEGIN            : 'begin'           ;
  BOOLEAN          : 'boolean'         ;
  CASE             : 'case'            ;
  CHAR             : 'char'            ;
  CHR              : 'chr'             ;
  CONST            : 'const'           ;
  DIV              : 'div'             ;
  DO               : 'do'              ;
  DOWNTO           : 'downto'          ;
  ELSE             : 'else'            ;
  END              : 'end'             ;
  FILE             : 'file'            ;
  FOR              : 'for'             ;
  FUNCTION         : 'function'        ;
  GOTO             : 'goto'            ;
  IF               : 'if'              ;
  IN               : 'in'              ;
  INTEGER          : 'integer'         ;
  LABEL            : 'label'           ;
  MOD              : 'mod'             ;
  NIL              : 'nil'             ;
  NOT              : 'not'             ;
  OF               : 'of'              ;
  OR               : 'or'              ;
  PACKED           : 'packed'          ;
  PROCEDURE        : 'procedure'       ;
  PROGRAM          : 'program'         ;
  REAL             : 'real'            ;
  RECORD           : 'record'          ;
  REPEAT           : 'repeat'          ;
  SET              : 'set'             ;
  THEN             : 'then'            ;
  TO               : 'to'              ;
  TYPE             : 'type'            ;
  UNTIL            : 'until'           ;
  VAR              : 'var'             ;
  WHILE            : 'while'           ;
  WITH             : 'with'            ;

//----------------------------------------------------------------------------
// OPERATORS
//----------------------------------------------------------------------------
PLUS            : '+'   ;
MINUS           : '-'   ;
STAR            : '*'   ;
SLASH           : '/'   ;
ASSIGN          : ':='  ;
COMMA           : ','   ;
SEMI            : ';'   ;
COLON           : ':'   ;
EQUAL           : '='   ;
NOT_EQUAL       : '<>'  ;
LT              : '<'   ;
LE              : '<='  ;
GE              : '>='  ;
GT              : '>'   ;
LPAREN          : '('   ;
RPAREN          : ')'   ;
LBRACK          : '['   ; // line_tab[line]
LBRACK2         : '(.'  ; // line_tab(.line.)
RBRACK          : ']'   ;
RBRACK2         : '.)'  ;
POINTER         : '^'   ;
AT              : '@'   ;
DOT             : '.'   ; // ('.' {$setType(DOTDOT);})?  ;
DOTDOT          : '..'  ;
LCURLY          : '{'   ;
RCURLY          : '}'   ;
UNIT            : 'unit'            ;
INTERFACE       : 'interface'       ;
USES            : 'uses'            ;
STRING          : 'string'          ;
IMPLEMENTATION  : 'implementation'  ;

/*
// Whitespace -- ignored
WS      : ( ' '
		|	'\t'
		|	'\f'
		// handle newlines
		|	(	'\r\n'  // DOS
			|	'\r'    // Mac
			|	'\n'    // Unix
			)
			{ //newline();
			}
		)
		{ $channel=HIDDEN; }
	;
*/
/*  //todo
COMMENT_1
        : '(*'
           (
		  // ( options { generateAmbigWarnings=false; }
		   :	{input.LA(2) != ')' }? '*'
		   |	'\r' '\n'	//	{newline();}
		   |	'\r'		//	{newline();}
		   |	'\n'		//	{newline();}
           |   ~('*' | '\n' | '\r')
		   )*
          '*)'
		{$channel=HIDDEN;}
	;

COMMENT_2
        :  '{'
           (
		   // ( options {generateAmbigWarnings=false;}
            :   '\r' '\n'      // {newline();}
		    |	'\r'			//{newline();}
		    |	'\n'			//{newline();}
            |   ~('}' | '\n' | '\r')
		    )*
           '}'
		{$channel=HIDDEN;}
	;
*/
// an identifier.  Note that testLiterals is set to true!  This means
// that after we match the rule, we look in the literals table to see
// if it's a literal or really an identifer
IDENT
	//options {testLiterals=true;}
	:	('a'..'z') ('a'..'z'|'0'..'9'|'_')*   //pspsps
	;

// string literals
STRING_LITERAL
	: '\'' ('\'\'' | ~('\''))* '\''   //pspsps   * in stead of + because of e.g. ''
	;

/** a numeric literal.  Form is (from Wirth)
 *  digits
 *  digits . digits
 *  digits . digits exponent
 *  digits exponent
 */
 /*
NUM_INT
	:	DIGIT+ // everything starts with a digit sequence
		(	(	{(input.LA(2)!='.')&&(input.LA(2)!=')')}?				// force k=2; avoid ".."
//PSPSPS example ARRAY (.1..99.) OF char; // after .. thinks it's a NUM_REAL
				'.' {$type = NUM_REAL;}	// dot means we are float
				DIGIT+ (EXPONENT)?
			)?
		|	EXPONENT {$type=NUM_REAL;}	// 'E' means we are float
		)
	;
*/

// not considered as token - fragments are some kind of macros for token definition
fragment
EXPONENT    :	('e') ('+'|'-')? ('0'..'9')+    ;
DIGIT       :   [0-9]                          ;
