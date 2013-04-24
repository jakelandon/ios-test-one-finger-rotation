//
//  MathUtil.h
//  OneFingerRotation
//
//  Created by jschwartz on 10/13/10.
//  Copyright 2010 BSSP. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MathUtil : NSObject {

}

// angle conversion
+ (float)radiansToDegrees:(float)radians;
+ (float)degreesToRadians:(float)degrees;

// angle formulas
+ (float)angleBetweenPointsInRadians:(CGPoint)p1 point2:(CGPoint)p2;
@end
