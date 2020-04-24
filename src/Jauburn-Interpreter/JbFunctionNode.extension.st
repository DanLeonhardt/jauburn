Extension { #name : #JbFunctionNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionNode >> evaluateIn: environment [ 

	| jbF |
	jbF := JbFunction new.
	jbF body: self body.
	jbF parameters: (self parameters collect: [:each | each identifier]).
	jbF environment: environment.
	^jbF.
]
