//
//  MathUtil.m
//  OneFingerRotation
//
//  Created by jschwartz on 10/13/10.
//  Copyright 2010 BSSP. All rights reserved.
//

#import "MathUtil.h"


@implementation MathUtil


+ (float)radiansToDegrees:(float)radians {
	return radians / ( M_PI / 180 ); 
}

+ (float)degreesToRadians:(float)degrees {
	return degrees * ( M_PI / 180 );
}

+ (float)angleBetweenPointsInRadians:(CGPoint)p1 point2:(CGPoint)p2 {
	float dx = p2.x - p1.x;
	float dy = p2.y - p1.y;
	float angleInRadians = atan( dy / dx );
	float angleInDegrees = [self radiansToDegrees:angleInRadians]; 
	
	if ( dx < 0) 
	{
		angleInDegrees += 180;
	}
	if ( dx >= 0 && dy < 0) 
	{
		angleInDegrees += 360;
	}
	
	return [self degreesToRadians:angleInDegrees];
}

@end
