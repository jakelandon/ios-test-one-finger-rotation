//
//  OneFingerRotationAppDelegate.h
//  OneFingerRotation
//
//  Created by jschwartz on 10/12/10.
//  Copyright 2010 BSSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OneFingerRotationViewController;

@interface OneFingerRotationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    OneFingerRotationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet OneFingerRotationViewController *viewController;

@end

