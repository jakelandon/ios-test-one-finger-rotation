//
//  OneFingerRotationViewController.m
//  OneFingerRotation
//
//  Created by jschwartz on 10/12/10.
//  Copyright 2010 BSSP. All rights reserved.
//

#import "OneFingerRotationViewController.h"

@implementation OneFingerRotationViewController



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	dial = [[OneFingerDial alloc] initWithFrame:CGRectZero];
	dial.center = CGPointMake( 768 / 2, 1024 / 2 );
	//dial.startRotation = 90;
	dial.maximumRotation = 360;
	dial.minimumValue = 1.0;
	dial.maximumValue = 7.0;
	dial.delegate = self;
	[self.view addSubview:dial];
	[dial release];
	
    [super viewDidLoad];
}

- (void) oneFingerDialDidRotate:(OneFingerDial *)ofd
{
	//NSLog(@"dial did rotate: %f", ofd.currentValue);
}

- (void) oneFingerDialDidStopRotating:(OneFingerDial *)ofd
{
	
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
