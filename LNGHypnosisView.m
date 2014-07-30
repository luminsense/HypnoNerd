//
//  LNGHypnosisView.m
//  Hypnosister
//
//  Created by Lumi on 14-6-27.
//  Copyright (c) 2014年 LumiNg. All rights reserved.
//

#import "LNGHypnosisView.h"

@interface LNGHypnosisView ()

@property (strong, nonatomic) UIColor *circleColor;

@end


@implementation LNGHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // draw circles
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    float maxRadius= hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        // Move to point to avoid connecting path
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    
    path.lineWidth = 10;
    [self.circleColor setStroke];
    [path stroke];  // draw the line
    
    /*
    // DRAW TRIANGLE WITH GRADIENT
    CGContextSaveGState(currentContext);
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0 };
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    
    CGPoint startPoint = CGPointMake(160.0, 0.0);
    CGPoint endPoint = CGPointMake(160.0, 640.0);
    
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    [trianglePath moveToPoint:CGPointMake(160, 100)];
    [trianglePath addLineToPoint:CGPointMake(280, 400)];
    [trianglePath addLineToPoint:CGPointMake(40, 400)];
    [trianglePath addClip];
    
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    CGContextRestoreGState(currentContext);
    
    // DRAW IMAGE WITH SHADOW
    CGContextSaveGState(currentContext);
    
    CGContextSetShadow(currentContext, CGSizeMake(0, 4), 4);
    UIImage *logoImage = [UIImage imageNamed:@"image.png"];
    CGRect imageRect = CGRectMake(center.x - 50, center.y - 50, 100, 100);
    [logoImage drawInRect:imageRect];
    
    CGContextRestoreGState(currentContext);
     */
}

// TOUCH SCREEN EVENT HANDLER
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
    // Get 3 random numbers between 0 and 1
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}


- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay]; // Prepare for redraw
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
