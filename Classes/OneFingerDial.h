//
//  OneFingerDial.h
//  OneFingerRotation
//
//  Created by jschwartz on 10/12/10.
//  Copyright 2010 BSSP. All rights reserved.
//

#import <UIKit/UIKit.h>

// definitions
#define kTimerInterval 1.0/60.0
#define kDialFriction 0.85

// enumerators
typedef enum {
	RotationDirectionClockwise,
	RotationDirectionCounterClockwise
} RotationDirection;

@class OneFingerDial;

// delegate protocol
@protocol OneFingerDialDelegate

@optional
- (void)oneFingerDialDidRotate:(OneFingerDial *)ofd;
- (void)oneFingerDialDidStopRotating:(OneFingerDial *)ofd;

@end


@interface OneFingerDial : UIView {

@public

	// delegate
	id <OneFingerDialDelegate> delegate; 
	
	// data vars
	float startRotation; // rotation in degrees where to start dial
	float maximumRotation; // amount of degrees from start that the dial can rotate
	float rotation; // the actual rotation, in degrees, of the dial
	int totalRotations; // total rotations of the dial
	float minimumValue; // minimum value for the dial
	float maximumValue; // maximum value for the dial
	float currentValue; // current value dial is rotated to
	
	BOOL snapsToValues; // determines whether or not dial should snap to values
	NSMutableArray *values;
	
@private
	
	// display vars
	UIImageView *imgView;
	
	// touch vars
	UIPanGestureRecognizer *panRecognizer;
	
	// rotation vars
	float _startRotation;
	float _maximumRotation;
	float _rotationOffset; // difference btw current rotation and where user touches
	float _lastRotation; // rotation from previous touch event, used to determine rotation direction
	float _currentVelocity; // current velocity of the dial, used to decelerate after user releases
	RotationDirection currentRotationDirection; // current direction dial is spinning
	CGPoint dialCenter; // center of the dial
	
	// util vars
	NSTimer *rotateToStopTimer; 
	
	}

// public properties
@property (nonatomic, assign) id <OneFingerDialDelegate> delegate;
@property (nonatomic, assign) int totalRotations;
@property (nonatomic, assign) float startRotation;
@property (nonatomic, assign) float maximumRotation;
@property (nonatomic, assign) float rotation;
@property (nonatomic, assign) float minimumValue;
@property (nonatomic, assign) float maximumValue;
@property (nonatomic, assign) float currentValue;

@property (nonatomic, assign) BOOL snapsToValues;


// methods


// setters and getters

- (float) currentValue;
- (void) setCurrentValue:(float)value;

- (float) minimumValue;
- (void) setMinimumValue:(float)value;

- (float) maximumValue;
- (void) setMaximumValue:(float)value;

- (float) startRotation;
- (void) setStartRotation:(float)value;

- (float) maximumRotation;
- (void) setMaximumRotation:(float)value;

- (int) totalRotations;
- (void) setTotalRotations:(int)value;

- (float) rotation;
- (void) setRotation:(float)value;

@end
