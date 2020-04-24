Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #running }
JbInterpreterTest >> testAssignment [
	
	
	self interpret: 'var x = 0; x = 5;'.
	self assert: (interpreter environment at:'x') equals: 5.
	
	self should: [self interpret: 'z = 5;'] raise: KeyNotFound.

]

{ #category : #running }
JbInterpreterTest >> testBooleanExpressions [

	self interpret: 'var x = 3 == 3;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 == 1;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 < 3;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 < 2;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 < 4;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 <= 3;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 <= 2;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 <= 4;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 > 3;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 > 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 > 4;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 >= 3;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 >= 4;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 >= 1;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 3 != 3;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 3 != 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var x = 3 - 2;'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = 4 / 2;'.
	self assert: (interpreter environment at: 'x') equals: 2.
	
	self interpret: 'var x = 4 / 2 - 1;'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #running }
JbInterpreterTest >> testFunctionDefinition [

	self interpret: 'var f = function (x, y) {return 1;};'.
	self assert: (interpreter environment at: 'f') body size equals: 1.
	self assert: (interpreter environment at: 'f') parameters size equals: 2.
	self assert: (interpreter environment at: 'f') parameters first equals: 'x'.
	self assert: (interpreter environment at: 'f') parameters second equals: 'y'.
	self assert: (interpreter environment at: 'f') environment equals: interpreter environment.
	
	self interpret: 'var x = 1;var fun = function (x, y, z) {x = x + 1;return x;};'.
	self assert: (interpreter environment at: 'fun') body size equals: 2.
	self assert: (interpreter environment at: 'fun') parameters size equals: 3.
	self assert: (interpreter environment at: 'fun') parameters first equals: 'x'.
	self assert: (interpreter environment at: 'fun') parameters second equals: 'y'.
	self assert: (interpreter environment at: 'fun') environment equals: interpreter environment.
]

{ #category : #running }
JbInterpreterTest >> testIfElseStatements [
	
	
	self interpret: 'var x = 0;if (false) {x = 5;} else {x = 10;};'.
	self assert: (interpreter environment at:'x') equals: 10.
	
	self interpret: 'var x = 0;if (true) {x = 5;} else {x = 10;};'.
	self assert: (interpreter environment at:'x') equals: 5.
	
	self interpret: 'var x = 0;if (5 > 10) {x = 5;} else {x = 10;};'.
	self assert: (interpreter environment at:'x') equals: 10.
	
	self interpret: 'var x = 10;if (x > 10) {x = 5;} else {x = 15;};'.
	self assert: (interpreter environment at:'x') equals: 15.
	
	self interpret: 'var x = 5;var y = 10;if (x > y) {x = 10;} else {x = "hey";};'.
	self assert: (interpreter environment at:'x') equals: 'hey'.
]

{ #category : #running }
JbInterpreterTest >> testIfStatements [
	
	
	self interpret: 'var x = 0;if (true) {x = 5;};'.
	self assert: (interpreter environment at:'x') equals: 5.
	
	self interpret: 'var x = 0;if (false) {x = 5;};'.
	self assert: (interpreter environment at:'x') equals: 0.
	
	self interpret: 'var x = 0;if (1 < 2) {x = 5;};'.
	self assert: (interpreter environment at:'x') equals: 5.
	
	self interpret: 'var x = 0;if (1 > 2) {x = 5;};'.
	self assert: (interpreter environment at:'x') equals: 0.
	
	self interpret: 'var x = 10; var y = 20;if (x > y) {x = 5;};'.
	self assert: (interpreter environment at:'x') equals: 10.
	
	self interpret: 'var x = 10; var y = 20;if (x < y) {x = 5;y = 31;};'.
	self assert: (interpreter environment at:'x') equals: 5.
	
	self interpret: 'var x = 10; var y = 20;if (x < y) {x = 5;y = 31;};'.
	self assert: (interpreter environment at:'y') equals: 31.
]

{ #category : #running }
JbInterpreterTest >> testJbFunctionCallNode [

	self interpret: 'var t = 0;var f = function (x, y) {t = 1;};var callfunc = f(1, 2);'.
	self assert: (interpreter environment at: 'callfunc') body size equals: 1.
	self assert: (interpreter environment at: 'callfunc') parameters size equals: 2.
	self assert: (interpreter environment at: 'callfunc') parameters first equals: 'x'.
	self assert: (interpreter environment at: 'callfunc') parameters second equals: 'y'.
	self assert: (interpreter environment at: 'callfunc') environment equals: interpreter environment.
	
	self interpret: 'var p = 0;var func = function (x, y) {p = 100;};func(2, 3);'.
	self assert: (interpreter environment at: 'p') equals: 100.
	
	
]

{ #category : #running }
JbInterpreterTest >> testJbFunctionCallNodeWithArgs [

	
	self interpret: 'var p = 0;var func = function (x) {p = p + x;};func(2);'.
	self assert: (interpreter environment at: 'p') equals: 2.
	
	self interpret: 'var p = 0;var func = function (x, y) {p = p + x;};func(100, 50);'.
	self assert: (interpreter environment at: 'p') equals: 100.
	
	self interpret: 'var p = 0;var func = function (x, y) {p = y + x;};func(100, 50);'.
	self assert: (interpreter environment at: 'p') equals: 150.
	
	self interpret: 'var p = 0;var func = function (x, y, z) {p = y + x + z;};func(100, 50, 25);'.
	self assert: (interpreter environment at: 'p') equals: 175.
]

{ #category : #running }
JbInterpreterTest >> testReturnStatement [ 

	self interpret: 'var f = function (x, y) {return 3;};var callfunc = f(1, 2);'.
	self assert: (interpreter environment at: 'callfunc') equals: 3.
	
]

{ #category : #running }
JbInterpreterTest >> testUnaryNegation [

	self interpret: 'var x = -1;'.
	self assert: (interpreter environment at: 'x') equals: -1.
	
	self interpret: 'var x = -1 + 1;'.
	self assert: (interpreter environment at: 'x') equals: 0.
	
	self interpret: 'var x = -1 * -1;'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = -(-1);'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	
]
