lexer grammar ManchesterParser;

FULLIRI
/*    : an iri as defined in [rfc 3987], enclosed in a pair of < (u+3c) and > (u+3e) characters */
    :
    ;

PREFIXNAME
/*    : a finite sequence of characters matching the pname_ns production of [sparql] and not matching any of the keyword terminals of the syntax */
    :
    ;

ABBREVIATEDIRI
    /*: a finite sequence of characters matching the pname_ln production of [sparql]*/
    :
    ;

SIMPLEIRI
    /*: a finite sequence of characters matching the pn_local production of [sparql] and not matching any of the keyword terminals of the syntax*/
    :
    ;

NONZERO
    : ('1'..'9')
    ;

ZERO
    : '0'
    ;

INTEGER
    : 'integer'
    ;

DECIMAL
    : 'decimal'
    ;

FLOAT
    : 'float'
    ;

STRING
    : 'string'
    ;

NODEID
    /*: a finite sequence of characters matching the blank_node_label production of [sparql]*/
    ;

REFERENCE
    : '^^'
    ;

LANGUAGETAG
    /*: @ (u+40) followed a nonempty sequence of characters matching the langtag production from [bcp 47]*/
    ;

QUOTEDSTRING
    /*: a finite sequence of characters in which " (u+22) and \ (u+5c) occur only in pairs of the form \" (u+5c, u+22) and \\ (u+5c, u+5c), enclosed in a pair of " (u+22) characters*/
    ;

PLUS
    : '+'
    ;

MINUS
    : '-'
    ;

DOT
    : '.'
    ;

F
    : 'f'
    ;

E
    : 'e'
    ;

DATATYPE
    : 'datatype' COLON
    ;

CLASS
    : 'class' COLON
    ;

OBJECT_PROPERTY
    : 'objectproperty' COLON
    ;

DATA_PROPERTY
    : 'dataproperty' COLON
    ;

ANNOTATION_PROPERTY
    : 'annotationproperty' COLON
    ;

NAMED_INDIVIDUAL
    : 'namedindividual' COLON
    ;

ANNOTATIONS
    : 'annotations' COLON
    ;

PREFIX
    : 'prefix' COLON
    ;

ONTOLOGY
    : 'ontology' COLON
    ;

IMPORTX
    : 'import' CONON
    ;

INVERSE
    : 'inverse'
    ;

OR
    : 'or'
    ;

AND
    : 'and'
    ;

NOT
    : 'not'
    ;

    : '{'
    ;

    : '}'
    ;

    : '('
    ;

    : ')'
    ;

    : '['
    ;

    : ']'
    ;

COMMA
    : ','
    ;

LENGTH
    : 'length'
    ;

MIN_LENGTH
    : 'minlength'
    ;

MAX_LENGTH
    : 'maxlength'
    ;

PATTERN
    : 'pattern'
    ;

LANG_RANGE
    : 'langrange'
    ;

    : '<='
    ;

    : '<'
    ;

    : '>='
    ;

    : '>'
    ;

    : 'or'
    ;

    : 'that'
    ;

    : 'not'
    ;

    : 'not'
    ;

    : 'and'
    ;

    : 'not'
    ;

    : 'some'
    : 'only'
    : 'value'
    : 'self'
    : 'min'
    : 'max'
    : 'exactly'
    : 'some'
    : 'only'
    : 'value'
    : 'min'
    : 'max'

    : '{'
    : '}'
    : '('
    : ')'
    ;

    : 'datatype:'
    : 'annotations:'
    : 'equivalentto:'
    : 'annotations:'

    : 'class:'
    : 'annotations:'
    : 'subclassof:'
    : 'equivalentto:'
    : 'disjointwith:'
    : 'disjointunionof:'
    : 'haskey:'

    : 'objectproperty:'
    : 'annotations:
    : 'domain:'
    : 'range:'
    : 'characteristics:'
    : 'subpropertyof:'
    : 'equivalentto:'
    : 'disjointwith:'
    : 'inverseof:'
    : 'subpropertychain:'

O
    : 'o'
    ;

FUNCTIONAL
    : 'functional'
    ;

INVERSEFUNCTIONAL
    : 'inversefunctional'
    ;

REFLEXIVE
    : 'reflexive'
    ;

IRREFLEXIVE
    : 'irreflexive'
    ;

SYMMETRIC
    : 'symmetric'
    ;

ASYMMETRIC
    : 'asymmetric'
    ;

TRANSITIVE
    : 'transitive'
    ;

DATAPROPERTY
    : 'dataproperty:'
    ;

ANNOTATIONS
    : 'annotations:'
    ;

DOMAIN
    : 'domain:'
    ;

RANGE
    : 'range:'
    ;

CHARACTERISTICS
    : 'characteristics:'
    ;

FUNCTIONAL
    : 'functional'
    ;

SUBPROPERTY_OF
    : 'subpropertyof:'
    ;

    : 'equivalentto:'
    ;

    ; 'disjointwith:'
    ;

    : 'annotationproperty:'
    ;

    : 'annotations:'
    ;

    : 'domain:'
    ;

    : 'range:'
    ;

    : 'subpropertyof:'
    ;

    : 'individual:'
    ;

    : 'annotations:'
    ;

    : 'types:'
    ;

    : 'facts:'
    ;

    : 'sameas:'
    ;

    : 'differentfrom:'
    ;

NOT
    : 'not'
    ;

EQUIVALENT_CLASSES
    : 'equivalentclasses' SEMICOLON
    ;

DISJOINT_CLASSES
   | 'disjointclasses' SEMICOLON
   ;

EQUIVALENT_PROPERTIES
   | 'equivalentproperties' SEMICOLON
   ;

DISJOINT_PROPERTIES
   | 'disjointproperties' SEMICOLON
   ;

EQUIVALENT_PROPERTIES
   | 'equivalentproperties' SEMICOLON
   ;

DISJOINT_PROPERTIES
   | 'disjointproperties' SEMICOLON
   ;

SAME_INDIVIDUAL
   | 'sameindividual' SEMICOLON
   ;

DIFFERENT_INDIVIDUALS
   : 'differentindividuals' SEMICOLON
   ;

fragment
SEMICOLON
    : ':'
    ;
