//
//  OneFingerDial.m
//  OneFingerRotation
//
//  Created by jschwartz on 10/12/10.
//  Copyright 2010 BSSP. All rights reserved.
//

#import "OneFingerDial.h"
#import "MathUtil.h"

@implementation OneFingerDial

@synthesize delegate;
@synthesize totalRotations;
@synthesize startRotation;
@synthesize minimumValue, maximumValue, currentValue;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

		// create dial image
		UIImage *img = [UIImage imageNamed:@"dial.png"];
		imgView = [[UIImageView alloc] initWithImage:img];
		[self addSubview:imgView];
		[imgView release];
		
		// create swipe recognizer
		panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
																action:@selector(handlePan:)];
		panRecognizer.cancelsTouchesInView = NO;
		[self addGestureRecognizer:panRecognizer];
		[panRecognizer release];
		
		// set dial center and other variables
		dialCenter = CGPointMake( img.size.width / 2, img.size.height / 2 );
		
		// set default public vars
		self.minimumValue = 0.0;
		self.maximumValue = 1.0;
		self.currentValue = minimumValue;
		self.startRotation = 0.0;
		self.maximumRotation = 360.0;
		self.totalRotations = 0;
		
		// set default private vars
		_lastRotation = 0.0;
		_currentVelocity = 0.0;
		_rotationOffset = 0.0;
				
		// set frame
		self.frame = imgView.frame;
    }
    return self;
}


- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
	
	// get velocity for pan 
	CGPoint pv = [recognizer velocityInView:self];
	
	// calculate velocity to decelerate dial
	float dx = pv.x - 0;
	float dy = pv.y - 0;
	float totalV = sqrt(dx*dx+dy*dy);
	float directionVar = (currentRotationDirection == RotationDirectionClockwise) ? 1.0 : -1.0;
	float finalV = totalV * directionVar / 120;
	
	
	switch ( recognizer.state ) {
		
		// user began rotating dial
		case 1:
			
			break;
			
		// user let go of dial
		case 3:
			
			// set current velocity
			_currentVelocity = finalV;
			
			break;
		default:
			break;
	}
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// cancel timer if it's running
	if( [rotateToStopTimer isValid] || rotateToStopTimer != nil )
	{
		[rotateToStopTimer invalidate];
		rotateToStopTimer = nil;
	}

	// get point of touch
	UITouch *t = [touches anyObject];
	CGPoint tl = [t locationInView:self];
	
	// set rotation offset
	float touchRotation = [MathUtil angleBetweenPointsInRadians:dialCenter point2:tl];
	if(touchRotation > rotation)
		_rotationOffset = (rotation + 2 * M_PI) - touchRotation;
	else 
		_rotationOffset = rotation - touchRotation;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	// get point of touch
	UITouch *t = [touches anyObject];
	CGPoint tl = [t locationInView:self];
	
	// adjust rotation with rotation offset
	float touchRotation = [MathUtil angleBetweenPointsInRadians:dialCenter point2:tl];
	float adjRotation = touchRotation + _rotationOffset;
	
	//NSLog(@"touch rotation: %f, %f, %f", [MathUtil radiansToDegrees:touchRotation], [MathUtil radiansToDegrees:_rotationOffset], [MathUtil radiansToDegrees:adjRotation]);
	
	// rotate image view
	self.rotation = adjRotation;
	
	// determine direction of rotation
	if(touchRotation - _lastRotation < 0.0 )
		currentRotationDirection = RotationDirectionCounterClockwise;
	else 
		currentRotationDirection = RotationDirectionClockwise;
	
	// set last rotation
	_lastRotation = touchRotation;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	// get point of touch
	UITouch *t = [touches anyObject];
	CGPoint tl = [t locationInView:self];
	
	// adjust rotation with rotation offset
	float touchRotation = [MathUtil angleBetweenPointsInRadians:dialCenter point2:tl];
	float adjRotation = touchRotation + _rotationOffset;

	// animate to stop
	rotateToStopTimer = [NSTimer scheduledTimerWithTimeInterval:kTimerInterval
														 target:self
													   selector:@selector(rotateToStopTimerHandler:)
													   userInfo:nil
														repeats:YES];
}



- (void)rotateToStopTimerHandler:(NSTimer *)timer
{
	// set current velocity
	_currentVelocity = _currentVelocity * kDialFriction;
	
	// if _currentVelocity is less than 0.1 stop timer
	if(_currentVelocity <= 0.1 && _currentVelocity >= -0.1)
	{
		// set current velocity to 0
		_currentVelocity = 0;
		
		// invalidate timer
		[rotateToStopTimer invalidate];
		rotateToStopTimer = nil;
		
		// call delegate method
		[[self delegate] oneFingerDialDidStopRotating:self];
	}
	
	// adjust current rotation
	float newRotationToAdd = _currentVelocity / kTimerInterval;
	
	// set rotation
	self.rotation = rotation + newRotationToAdd;
}


- (float) currentValue { return currentValue; }
- (void) setCurrentValue:(float)value {
	currentValue = value;
	NSLog(@"current val: %f", currentValue );
	/*if(currentValue <= minimumValue)
		currentValue = minimumValue;
	if(currentValue >= maximumValue)
		currentValue = maximumValue;*/
}
- (float) minimumValue { return minimumValue; }
- (void) setMinimumValue:(float)value {
	minimumValue = value;
}
- (float) maximumValue { return maximumValue; }
- (void) setMaximumValue:(float)value {
	maximumValue = value;
}

- (float) startRotation { return startRotation; }
- (void) setStartRotation:(float)value {
	startRotation = value;

	// convert to radians
	_startRotation = [MathUtil degreesToRadians:value];
	
	self.transform = CGAffineTransformMakeRotation(_startRotation);
	
	self.rotation = 0.0;
}
- (float) maximumRotation { return maximumRotation; }
- (void) setMaximumRotation:(float)value {
	maximumRotation = value;
	
	// convert to radians
	_maximumRotation = [MathUtil degreesToRadians:value];
}

- (int) totalRotations { return totalRotations; }
- (void) setTotalRotations:(int)value {
	totalRotations = value;
	
	NSLog(@"set total rotations: %i", totalRotations );
}
		


- (float) rotation { return rotation; }
- (void) setRotation:(float)value {
	rotation = value;

	// adjust rotation
	if(rotation > 2.0 * M_PI )
	{
		rotation -= 2.0 * M_PI;
	}
	
	
	// limit rotation if necessary
	/*if(_startRotation)
		if(rotation <= _startRotation)
			rotation = _startRotation;
	
	if(_maximumRotation)
	{
		if(rotation >= _startRotation + _maximumRotation)
			rotation = _startRotation + _maximumRotation;
	}*/
	
	// find pct rotated
	float pctRotated =  rotation / (2 * M_PI);//(rotation - _startRotation) / _maximumRotation;//((2 * M_PI) - 0);///[MathUtil radiansToDegrees:rotation] / 360.0;
	
	// set current value
	self.currentValue = minimumValue + (maximumValue - minimumValue) * pctRotated;

	
	//NSLog(@"rotation: %f, %f, %f, %f, %f", value, [MathUtil radiansToDegrees:rotation], pctRotated, currentValue, _rotationOffset );
	
	
	// set rotation of dial
	imgView.transform = CGAffineTransformMakeRotation(rotation);
	
	
	// call delegate function
	[[self delegate] oneFingerDialDidRotate:self];
}


- (void)dealloc 
{
	delegate = nil;
    [super dealloc];
}


@end
