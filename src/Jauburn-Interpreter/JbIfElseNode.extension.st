Extension { #name : #JbIfElseNode }

{ #category : #'*Jauburn-Interpreter' }
JbIfElseNode >> executeIn: environment [ 

	| cond  tStatements fStatements |
	cond := self condition evaluateIn: environment.
	tStatements := self trueStatements.
	fStatements := self falseStatements.
	^cond ifTrue: [ tStatements do: [ :statement | statement executeIn: environment ]] ifFalse: [ fStatements do: [ :statement | statement executeIn: environment ] ]
]
