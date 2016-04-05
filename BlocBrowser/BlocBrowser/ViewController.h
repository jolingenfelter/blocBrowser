//
//  ViewController.h
//  BlocBrowser
//
//  Created by Joanna Lingenfelter on 4/4/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/** Replaces the web view with a fresh one, erasing all history.  Also updates the URL field and toolbar buttons appropriately.
 */

- (void) resetWebView;


@end

