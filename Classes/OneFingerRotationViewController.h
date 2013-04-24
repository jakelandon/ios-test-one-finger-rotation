//
//  OneFingerRotationViewController.h
//  OneFingerRotation
//
//  Created by jschwartz on 10/12/10.
//  Copyright 2010 BSSP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OneFingerDial.h"

@interface OneFingerRotationViewController : UIViewController <OneFingerDialDelegate> {

	OneFingerDial *dial;
}

@end

