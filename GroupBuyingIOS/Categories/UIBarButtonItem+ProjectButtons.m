//
//  UIBarButtonItem+ProjectButtons.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 02.10.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "UIBarButtonItem+ProjectButtons.h"

@implementation UIBarButtonItem (ProjectButtons)

+ (UIBarButtonItem *)backArrowButtonWithTarget:(id)target action:(SEL)action
{
    UIImage *buttonImage = [UIImage imageNamed:@"backButton.png"];
    
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return customBarItem;
}
@end
