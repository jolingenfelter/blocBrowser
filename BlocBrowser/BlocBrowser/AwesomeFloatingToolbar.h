//
//  AwesomeFloatingToolbar.h
//  BlocBrowser
//
//  Created by Joanna Lingenfelter on 4/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AwesomeFloatingToolbar;

@protocol AwesomeFloatingToolbarDelegate <NSObject>

@optional

- (void) floatingToolbar: (AwesomeFloatingToolbar*)toolbar didSelectButtonWithTitle: (NSString *)title;

- (void) floatingToolbar: (AwesomeFloatingToolbar *)toolbar didTryToPanWithOffset:(CGPoint)offset;

- (void) floatingToolbar: (AwesomeFloatingToolbar *) toolbar didTryToPinchWithScale: (CGFloat)scale;


@end

@interface AwesomeFloatingToolbar : UIView

- (instancetype) initWithFourTitles: (NSArray *)titles;

- (void) setEnabled:(BOOL)enabled forButtonWithTitle: (NSString *) title;


@property (nonatomic, weak) id <AwesomeFloatingToolbarDelegate> delegate;

@end
