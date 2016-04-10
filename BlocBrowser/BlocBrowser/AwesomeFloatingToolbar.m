//
//  AwesomeFloatingToolbar.m
//  BlocBrowser
//
//  Created by Joanna Lingenfelter on 4/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "AwesomeFloatingToolbar.h"

@interface AwesomeFloatingToolbar ()

@property (nonatomic, strong) NSArray *currentTitles;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation AwesomeFloatingToolbar

- (instancetype) initWithFourTitles:(NSArray *)titles {
    // First, call the superclass (UIView)'s initializer, to make sure we do all of that setup first.
    
    self = [super init];
    
    if (self) {
        
        //Save the titles, and set 4 colors
        
        self.currentTitles = titles;
        
        self.colors = @[[UIColor colorWithRed:199/255.0 green:158/255.0 blue:203/255.0 alpha:1],
                        [UIColor colorWithRed:255/255.0 green:105/255.0 blue:97/255.0 alpha:1],
                        [UIColor colorWithRed:222/255.0 green:165/255.0 blue:164/255.0 alpha:1],
                        [UIColor colorWithRed:255/255.0 green:179/255.0 blue:71/255.0 alpha:1]];
        
        
        
        NSMutableArray *buttonsArray = [[NSMutableArray alloc] init];
    
        for (NSString *currentTitle in self.currentTitles) {
            UIButton *button = [[UIButton alloc] init];
            
            NSUInteger currentTitleIndex = [self.currentTitles indexOfObject:currentTitle]; // 0 through3
            NSString *titleForThisButton = [self.currentTitles objectAtIndex: currentTitleIndex];
            UIColor *colorForThisButton = [self.colors objectAtIndex:currentTitleIndex];
            
            [button setTitle:titleForThisButton forState:UIControlStateSelected];
            [button setTintColor:colorForThisButton];
            button.titleLabel.font = [UIFont systemFontOfSize:10];
            button.titleLabel.textColor = [UIColor whiteColor];
            
            [buttonsArray addObject:button];
        
        }
        
        self.buttons= buttonsArray;
        
        for (UIButton *thisButton in self.buttons) {
            [self addSubview:thisButton];
        }


        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFired:)];
        [self addGestureRecognizer:self.panGesture];
        
        
    }
    
    return self;
}

- (void) layoutSubviews {
    
    //set the frames for the 4 labels
    
    for (UIButton *thisButton in self.buttons) {
        
        NSUInteger currentButtonIndex = [self.buttons indexOfObject:thisButton];
        
        CGFloat buttonHeight = CGRectGetHeight(self.bounds) / 2;
        CGFloat buttonWidth = CGRectGetWidth(self.bounds) / 2;
        CGFloat buttonX = 0;
        CGFloat buttonY = 0;
        
        // adjust labelX and labelY for each label
        
        if (currentButtonIndex < 2) {
            
            //0 or 1, so on top
            
            buttonY = 0;
            
        } else {
             // 2 or 3, so on bottom
            
            buttonY = CGRectGetHeight(self.bounds) / 2;
        }
        
        if (currentButtonIndex % 2 == 0) { // is currentLabelIndex evenly divisible by 2?
            
            // 0 or 2, so on the left
            
            buttonX = 0;
        } else {
            
            // 1 or 3, so on the right
            buttonX = CGRectGetWidth(self.bounds) / 2;
        }
        
        thisButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        
    }
}

#pragma mark Gesture Recognizers


- (void) panFired:(UIPanGestureRecognizer *)recognizer {
    
    if(recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self];
        
        NSLog(@"New translation: %@", NSStringFromCGPoint(translation));
        
        if ([self.delegate respondsToSelector:@selector(floatingToolbar:didTryToPanWithOffset:)]) {
            
            [self.delegate floatingToolbar:self didTryToPanWithOffset:translation];
        }
        
        [recognizer setTranslation:CGPointZero inView:self];
        
    }
}


#pragma mark - Button Enabling


- (void) setEnabled:(BOOL)enabled forButtonWithTitle:(NSString *)title {
    NSUInteger index = [self.currentTitles indexOfObject:title];
    
    if (index != NSNotFound) {
        UIButton *button = [self.buttons objectAtIndex:index];
        button.userInteractionEnabled = enabled;
        button.alpha = enabled ? 1.0 : 0.25;
    }
}


@end
