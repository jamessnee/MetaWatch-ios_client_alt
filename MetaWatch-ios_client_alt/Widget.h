//
//  Widget.h
//  MetaWatch-ios_client_alt
//
//  Created by James Snee on 15/08/2012.
//  Copyright (c) 2012 James Snee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Widget : NSObject

//IVars
@property (strong,nonatomic) UIView *view_buffer;
@property (nonatomic) NSInteger *update_rate;
@property (nonatomic) NSInteger *timestamp;

//Methods
- (UIView *) update_view;
- (void) initialise_widget;

@end
