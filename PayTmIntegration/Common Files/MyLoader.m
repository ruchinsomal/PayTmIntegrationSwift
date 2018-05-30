//
//  MyLoader.m
//  AddNum
//
//  Created by ruchin somal on 10/05/16.
//  Copyright © 2016 ruchin somal. All rights reserved.
//

#import "MyLoader.h"

@implementation MyLoader
- (id)init
{
    self = [super init];
    if (self) {
        
        // Background with alpha so the view is transculent.
        //self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.85];
        self.backgroundColor = [UIColor clearColor];
        
        // Get the size of the entire screen
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        // Set the frame to be equal to the screen size
        self.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
        
        //let's create a view
        UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        myView.backgroundColor = [UIColor darkGrayColor];
        myView.center = self.center;
        myView.layer.cornerRadius = 10;
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(35, 10, 30, 50)];
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [activityView startAnimating];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 100, 50)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        label.text = @"Loading...";
        [myView addSubview:activityView];
        [myView addSubview:label];
        
        [self addSubview:myView];
        
    }
    return self;
}
+ (instancetype)privateInstance
{
    static dispatch_once_t once;
    static MyLoader *privateInstance;
    dispatch_once(&once, ^{
        privateInstance = [[self alloc] init];
    });
    return privateInstance;
}

+ (void)showLoadingView
{
    MyLoader *loadingView = [MyLoader privateInstance];
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:loadingView];
}

+ (void)hideLoadingView
{
    MyLoader *loadingView = [MyLoader privateInstance];
    [loadingView removeFromSuperview];
}


+ (void)showLoadingView:(UIView *)view {
    MyLoader *loadingView = [MyLoader privateInstance];
    [view addSubview:loadingView];
}
+ (void)hideLoadingView:(UIView *)view {
    MyLoader *loadingView = [MyLoader privateInstance];
    [loadingView removeFromSuperview];
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
