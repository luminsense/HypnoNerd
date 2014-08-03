//
//  LNGHypnosisViewController.m
//  HypnoNerd
//
//  Created by Lumi on 14-7-1.
//  Copyright (c) 2014年 LumiNg. All rights reserved.
//

#import "LNGHypnosisViewController.h"
#import "LNGHypnosisView.h"

@interface LNGHypnosisViewController () <UITextFieldDelegate>
@property (nonatomic, weak) UITextField *textField;
@end

@implementation LNGHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Set the tab bar item
        self.tabBarItem.title = @"Hypnotize";
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)loadView
{
    // Create a view
    CGRect frame = [UIScreen mainScreen].bounds;
    LNGHypnosisView *backgroundView = [[LNGHypnosisView alloc] initWithFrame:frame];
    
    // Create a text field
    CGRect textFieldRect = CGRectMake(40, -30, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me!";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    
    [backgroundView addSubview:textField];
    
    self.textField = textField;
    
    // Set it as *the* view of this view controller
    self.view = backgroundView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.0
                        options:0
                     animations:^{
                         CGRect frame = CGRectMake(40, 70, 240, 30);
                         self.textField.frame = frame;
                     }
                     completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];
    
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++) {
        
        UILabel *messageLabel = [[UILabel alloc] init];
        
        // Configure the label's colors and text
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.text = message;
        
        // Auto resize (relative to the text)
        [messageLabel sizeToFit];
        
        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        int x = arc4random() % width;
        int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
        int y =arc4random() % height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
        
        // Animation
        messageLabel.alpha = 0.0;
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             messageLabel.alpha = 1.0;
                         }
                         completion:NULL];
        
        [UIView animateKeyframesWithDuration:1.0
                                       delay:0.0
                                     options:0
                                  animations:^{
                                      [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8 animations:^{
                                          messageLabel.center = self.view.center;
                                      }];
                                      [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
                                          int x = arc4random() % width;
                                          int y = arc4random() % height;
                                          messageLabel.center = CGPointMake(x, y);
                                      }];
                                  }
                                  completion:^(BOOL finished){
                                      NSLog(@"Animation Finished");
                                  }];
        
        // Add a vertical and horizontal motion effect
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
    }
}


@end
