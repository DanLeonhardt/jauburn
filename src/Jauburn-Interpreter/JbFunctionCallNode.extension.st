Extension { #name : #JbFunctionCallNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionCallNode >> evaluateIn: environment [ 

	| jbF |
	jbF := JbFunction new.
	jbF body: (environment at: identifier) body.
	jbF parameters: (environment at: identifier) parameters.
	jbF environment: environment.
	^jbF.
]

{ #category : #'*Jauburn-Interpreter' }
JbFunctionCallNode >> executeIn: environment [ 

	| jbF |
	jbF := JbFunction new.
	jbF body: (environment at: identifier) body.
	jbF parameters: (environment at: identifier) parameters.
	jbF environment: environment.
	
	
	1 to: (jbF parameters size) do: [ :i | jbF environment at: (jbF parameters at:i) put: ((self arguments at: i) evaluateIn:environment) ].
	jbF body do: [ :statement | statement executeIn: environment ].
	^jbF.
]
