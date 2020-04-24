Extension { #name : #JbArity1OperatorNode }

{ #category : #'*Jauburn-Interpreter' }
JbArity1OperatorNode >> evaluateIn: environment [ 

	|  operatorValue operandValue |
	operatorValue := self operator.
	operandValue := self operand evaluateIn: environment.
	self operator = $-
		ifTrue: [ ^operandValue  * -1 ].
]
