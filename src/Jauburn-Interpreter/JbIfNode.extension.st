Extension { #name : #JbIfNode }

{ #category : #'*Jauburn-Interpreter' }
JbIfNode >> executeIn: environment [ 
	
	| cond statements |
	cond := self condition evaluateIn: environment.
	statements := self trueStatements.
	
	^cond ifTrue: [ statements do: [ :statement | statement executeIn: environment ]]
]
