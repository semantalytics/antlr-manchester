parser grammar ManchesterParser;


https://www.w3.org/tr/owl2-manchester-syntax/


 2 the grammar

the manchester syntax for owl 2 ontologies is defined using a standard bnf notation, which is summarized in the table below.
table 1. the bnf notation used in this document construct 	syntax 	example

non-terminal symbols 	boldface 	classexpression
terminal symbols 	single quoted 	'propertyrange'
zero or more 	curly braces 	{ classexpression }
zero or one 	square brackets 	[ classexpression ]
alternative 	vertical bar 	assertion | declaration
grouping 	parentheses 	datapropertyexpression )

because comma-separated lists occur in very many places in the syntax, to save space the grammar has three
meta-productions, one for non-empty lists, one for lists of minimum length two, and one for non-empty lists with
annotations in them.

<nt>list ::= <nt> { ',' <nt> }
<nt>2list ::= <nt> ',' <nt>list
<nt>annotatedlist ::= [annotations] <nt> { ',' [annotations] <nt> }


documents in the manchester owl syntax form owl 2 ontologies and consist of sequences of unicode characters [unicode] and are encoded in utf-8 [rfc 3629].

the grammar for the manchester syntax does not explicitly show white space. white space is allowed between any two terminals or non-terminals except inside nonnegativeinteger, prefixname, iri, and literal. white space is required between two terminals or non-terminals if its removal could cause ambiguity. generally this means requiring white space except before and after punctuation (e.g., commas, parentheses, braces, and brackets).

white space is a sequence of blanks (u+20), tabs (u+9), line feeds (u+a), carriage returns (u+d), and comments. comments are maximal sequences of unicode characters starting with a '#' and not containing a line feed or a carriage return. note that comments are only recognized where white space is allowed, and thus not inside the above non-terminals.
2.1 iris, integers, literals, and entities

names are iris (the successors of uris) and can either be given in full or can be abbreviated similar to as in sparql [sparql]. abbreviated iris consist of an optional colon-terminated prefix followed by a local part. prefixes in abbreviated iris must not match any of the keywords of this syntax. prefixes should begin with lower case letters so that they do not clash with colon-terminated keywords introduced in future versions of this syntax. local parts with no prefix are expanded as if they had an initial colon and must not match any keyword of this syntax.

this syntax uses short forms for common data values, e.g., strings and numbers, and short forms for some common datatypes, e.g., integer. these correspond to the obvious long forms.

fulliri
    : an iri as defined in [rfc 3987], enclosed in a pair of < (u+3c) and > (u+3e) characters
    ;

prefixname
    : a finite sequence of characters matching the pname_ns production of [sparql] and not matching any of the keyword terminals of the syntax
    ;

abbreviatediri
    : a finite sequence of characters matching the pname_ln production of [sparql]
    ;

simpleiri
    : a finite sequence of characters matching the pn_local production of [sparql] and not matching any of the keyword terminals of the syntax
    ;

iri
    : fulliri
    | abbreviatediri
    | simpleiri
    ;

nonnegativeinteger
    : zero
    | positiveinteger
    ;

positiveinteger
    : nonzero digit*
    ;

digits
    : digit+
    ;

digit
    : zero
    | nonzero
    ;

nonzero
    : ('1'..'9')
    ;

zero
    : '0'
    ;

classiri
    : iri
    ;

datatype
    : datatypeiri
    | 'integer'
    | 'decimal'
    | 'float'
    | 'string'
    ;

datatypeiri
    : iri
    ;

objectpropertyiri
    : iri
    ;

datapropertyiri
    : iri
    ;

annotationpropertyiri
    : iri
    ;

individual
    : individualiri
    | nodeid
    ;

individualiri
    : iri
    ;

nodeid
    : a finite sequence of characters matching the blank_node_label production of [sparql]
    ;

literal
    : typedliteral
    | stringliteralnolanguage
    | stringliteralwithlanguage
    | integerliteral
    | decimalliteral
    | floatingpointliteral
    ;

typedliteral
    : lexicalvalue '^^' datatype
    ;

stringliteralnolanguage
    : quotedstring
    ;

stringliteralwithlanguage
    : quotedstring languagetag
    ;

languagetag
    : @ (u+40) followed a nonempty sequence of characters matching the langtag production from [bcp 47]
    ;

lexicalvalue
    : quotedstring
    ;

quotedstring
    : a finite sequence of characters in which " (u+22) and \ (u+5c) occur only in pairs of the form \" (u+5c, u+22) and \\ (u+5c, u+5c), enclosed in a pair of " (u+22) characters
    ;

floatingpointliteral
    : ( '+' | '-')? ( digits ('.'digits)? (exponent)? | '.' digits (exponent)?) ( 'f' | 'f' )
    ;

exponent
    : ('e' | 'e') ('+' | '-')? digits
    ;

decimalliteral
    : ('+' | '-')? digits '.' digits
    ;

integerliteral
    : ('+' | '-')? digits
    ;

entity
    : 'datatype'           '(' datatype ')'
    | 'class'              '(' classiri ')'
    | 'objectproperty'     '(' objectpropertyiri ')'
    | 'dataproperty'       '(' datapropertyiri ')'
    | 'annotationproperty' '(' annotationpropertyiri ')'
    | 'namedindividual'    '(' individualiri ')'
    ;

annotations
    : 'annotations:' annotationannotatedlist
    ;

annotation
    : annotationpropertyiri annotationtarget
    ;

annotationtarget
    : nodeid
    | iri
    | literal
    ;

ontologydocument
    :  prefixdeclaration* ontology
    ;

prefixdeclaration
    : 'prefix:' prefixname fulliri
    ;

ontology
    : 'ontology:' ( ontologyiri ( versioniri )? )? ( importx )? ( annotations )? ( frame )?
    ;

ontologyiri
    : iri
    ;

versioniri
    : iri
    ;

importx
    : 'import:' iri
    ;

frame
    : datatypeframe
    | classframe
    | objectpropertyframe
    | datapropertyframe
    | annotationpropertyframe
    | individualframe
    | misc
    ;

/*
the 'rdf:', 'rdfs:', 'owl:', and 'xsd:' prefixes are pre-defined as follows and cannot be changed. each other prefix
used in an ontology document must have exactly one prefix declaration in the ontology document.

prefix: rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix: rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix: xsd: <http://www.w3.org/2001/xmlschema#>
prefix: owl: <http://www.w3.org/2002/07/owl#>
*/

objectpropertyexpression
    : objectpropertyiri
    | inverseobjectproperty
    ;

inverseobjectproperty
    : 'inverse' objectpropertyiri
    ;

datapropertyexpression
    : datapropertyiri
    ;

datarange
    : dataconjunction ( 'or' dataconjunction )*
    ;

dataconjunction
    : dataprimary ( 'and' dataprimary )*
    ;

dataprimary
    : ( 'not' )? dataatomic
    ;

dataatomic
    : datatype
    | '{' literallist '}'
    | datatyperestriction
    | '(' datarange ')'
    ;

datatyperestriction
    : datatype '[' facet restrictionvalue ( ',' facet restrictionvalue )* ']'
    ;

facet
    : 'length'
    | 'minlength'
    | 'maxlength'
    | 'pattern'
    | 'langrange'
    | '<='
    | '<'
    | '>='
    | '>'
    ;

restrictionvalue
    : literal
    ;

/*
in a datatyperestriction, the facets and restrictionvalues must be valid for the datatype, as in the owl 2
specification [owl 2 specification], after making the obvious change for the comparison facets.
2.4 descriptions

the infix notation for descriptions is ambiguous as stated. this ambiguity is resolved in the usual way, with later
productions in the description grammar below binding more tightly, so, for example,

p some a and p only b

is parsed as

(p some a) and (p only b)

*/

description
    : conjunction ( 'or' conjunction )*
    ;

conjunction
    : classiri 'that' ( 'not' )? restriction ( 'and' ( 'not' )? restriction )*
    | primary ( 'and' primary )*
    ;

primary
    : ( 'not' )? ( restriction | atomic )
    ;

restriction
    : objectpropertyexpression 'some'    primary
    | objectpropertyexpression 'only'    primary
    | objectpropertyexpression 'value'   individual
    | objectpropertyexpression 'self'
    | objectpropertyexpression 'min'     nonnegativeinteger ( primary )?
    | objectpropertyexpression 'max'     nonnegativeinteger ( primary )?
    | objectpropertyexpression 'exactly' nonnegativeinteger ( primary )?
    | datapropertyexpression   'some'    dataprimary
    | datapropertyexpression   'only'    dataprimary
    | datapropertyexpression   'value'   literal
    | datapropertyexpression   'min'     nonnegativeinteger ( dataprimary )?
    | datapropertyexpression   'max'     nonnegativeinteger ( dataprimary )?
    | datapropertyexpression   'exactly' nonnegativeinteger ( dataprimary )?
    ;

atomic
    : classiri
    | '{' individuallist '}'
    | '(' description ')'
    ;

datatypeframe
    : 'datatype:' datatype
       ( 'annotations:'     annotationannotatedlist )*
       ( 'equivalentto:' annotations datarange )?
       ( 'annotations:'     annotationannotatedlist )*
       ;

classframe
    : 'class:' classiri
       ( 'annotations:'     annotationannotatedlist
       | 'subclassof:'      descriptionannotatedlist
       | 'equivalentto:'    descriptionannotatedlist
       | 'disjointwith:'    descriptionannotatedlist
       | 'disjointunionof:' annotations description2list )*
       | 'haskey:' annotations ( objectpropertyexpression | datapropertyexpression )
                                        ( objectpropertyexpression | datapropertyexpression )*
                                        ;


objectpropertyframe
    : 'objectproperty:' objectpropertyiri
       ( 'annotations:'     annotationannotatedlist
       | 'domain:'          descriptionannotatedlist
       | 'range:'           descriptionannotatedlist
       | 'characteristics:' objectpropertycharacteristicannotatedlist
       | 'subpropertyof:'   objectpropertyexpressionannotatedlist
       | 'equivalentto:'    objectpropertyexpressionannotatedlist
       | 'disjointwith:'    objectpropertyexpressionannotatedlist
       | 'inverseof:'        objectpropertyexpressionannotatedlist
       | 'subpropertychain:' annotations objectpropertyexpression 'o' objectpropertyexpression
                                                ( 'o' objectpropertyexpression )* )*
                                                ;

objectpropertycharacteristic
    : 'functional'
    | 'inversefunctional'
    | 'reflexive'
    | 'irreflexive'
    | 'symmetric'
    | 'asymmetric'
    | 'transitive'
    ;

datapropertyframe
    : 'dataproperty:' datapropertyiri
       ( 'annotations:'     annotationannotatedlist
       | 'domain:'          descriptionannotatedlist
       | 'range:'           datarangeannotatedlist
       | 'characteristics:' annotations 'functional'
       | 'subpropertyof:'   datapropertyexpressionannotatedlist
       | 'equivalentto:'    datapropertyexpressionannotatedlist
       | 'disjointwith:'    datapropertyexpressionannotatedlist )*
       ;

annotationpropertyframe
    : 'annotationproperty:' annotationpropertyiri
       ( 'annotations:'     annotationannotatedlist )*
       | 'domain:'          iriannotatedlist
       | 'range:'           iriannotatedlist
       | 'subpropertyof:'   annotationpropertyiriannotatedlist
       ;

individualframe
    : 'individual:' individual
   ( 'annotations:'   annotationannotatedlist
   | 'types:'         descriptionannotatedlist
   | 'facts:'         factannotatedlist
   | 'sameas:'        individualannotatedlist
   | 'differentfrom:' individualannotatedlist )*
   ;

fact
    : ( 'not' )? (objectpropertyfact | datapropertyfact)
    ;

objectpropertyfact
    : objectpropertyiri individual
    ;

datapropertyfact
    : datapropertyiri literal
    ;

misc
   : 'equivalentclasses:'    annotations description2list
   | 'disjointclasses:'      annotations description2list
   | 'equivalentproperties:' annotations objectproperty2list
   | 'disjointproperties:'   annotations objectproperty2list
   | 'equivalentproperties:' annotations dataproperty2list
   | 'disjointproperties:'   annotations dataproperty2list
   | 'sameindividual:'       annotations individual2list
   | 'differentindividuals:' annotations individual2list
   ;
