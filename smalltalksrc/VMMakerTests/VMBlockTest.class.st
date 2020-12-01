Class {
	#name : #VMBlockTest,
	#superclass : #VMInterpreterTests,
	#pools : [
		'VMObjectIndices',
		'VMSqueakClassIndices'
	],
	#category : #'VMMakerTests-InterpreterTests'
}

{ #category : #supports }
VMBlockTest >> anEmptyMethod [
]

{ #category : #helpers }
VMBlockTest >> installBlockClosureClass [
		| aClass |
	aClass := self
		newClassInOldSpaceWithSlots: 0
		instSpec: BlockClosure instSpec.
	memory setHashBitsOf: aClass to: ClassBlockClosureCompactIndex.
	memory
		storePointer: ClassBlockClosureCompactIndex
		ofObject: memory classTableFirstPage
		withValue: aClass
]

{ #category : #helpers }
VMBlockTest >> installBlockClosureClassInSplOnly [
		| aClass |
	aClass := self
		newClassInOldSpaceWithSlots: 0
		instSpec: BlockClosure instSpec.
	memory setHashBitsOf: aClass to: ClassBlockClosureCompactIndex.
	memory splObj: ClassBlockClosure put: aClass
]

{ #category : #supports }
VMBlockTest >> methodReturningABlock [
	
	^ []
	
]

{ #category : #tests }
VMBlockTest >> testBlockClosureClassIsOnlyInSpecialObjectArrayShouldStillInstantiate [

	| methodOop methodHeader previousMethodOop |
	previousMethodOop := self createMethodOopFromPharoMethod:
		                     self class >> #anEmptyMethod.

	methodOop := self createMethodOopFromPharoMethod:
		             self class >> #methodReturningABlock.

	"To force the use of the specialObjectArray"
	ClassBlockClosureCompactIndex := 0.
	self installBlockClosureClassInSplOnly.
	"We want to avoid baseFrameReturn (base frame initialisation)"
	stackBuilder addNewFrame method: previousMethodOop.
	stackBuilder addNewFrame
		method: methodOop;
		receiver: memory trueObject.
	stackBuilder buildStack.
	methodHeader := memory methodHeaderOf: methodOop.

	interpreter interpretWhile: [ interpreter method = methodOop ].

	self
		assert: (memory fetchClassOf: interpreter stackTop)
		equals: (memory classAtIndex: ClassBlockClosureCompactIndex)
]

{ #category : #testing }
VMBlockTest >> testPushClosureBytecodePushesClosure [

	| methodOop previousMethodOop |
	previousMethodOop := self createMethodOopFromPharoMethod:
		                     self class >> #anEmptyMethod.

	methodOop := self createMethodOopFromPharoMethod:
		             self class >> #methodReturningABlock.

	self installBlockClosureClass.
	"We want to avoid baseFrameReturn (base frame initialisation)"
	stackBuilder addNewFrame method: previousMethodOop.
	stackBuilder addNewFrame
		method: methodOop;
		receiver: memory trueObject.
	stackBuilder buildStack.
	
	interpreter interpretWhile: [ interpreter method = methodOop ].

	self
		assert: (memory fetchClassOf: interpreter stackTop)
		equals: (memory classAtIndex: ClassBlockClosureCompactIndex)
]