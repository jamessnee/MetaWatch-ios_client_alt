//
//  Test_Widget.m
//  MetaWatch-ios_client_alt
//
//  Created by James Snee on 15/08/2012.
//  Copyright (c) 2012 James Snee. All rights reserved.
//

#import "Widget.h"

@implementation Widget

@synthesize view_buffer, update_rate;

- (id) init{
	self = [super init];
	if(self){
		[self initialise_widget];
	}
	return self;
}

- (UIView *) update_view{
	return [[UIView alloc] init];
}

- (void) initialise_widget{
	
}

@end
