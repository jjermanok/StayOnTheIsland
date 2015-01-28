//
//  MNKAccelViewController.m
//  followme
//
//  Created by Jake Jermanok on 6/16/14.
//  Copyright (c) 2014 Manok Inc. All rights reserved.
//

#import "MNKAccelViewController.h"

@interface MNKAccelViewController ()

@end

@implementation MNKAccelViewController

- (void)viewDidLoad
{
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/60];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    _ball.center = CGPointMake(110, 200);
    position = CGPointMake(.1,.1);
    _theHighScore = 0;
    _thescore = 0;
    [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(moveHole) userInfo:nil repeats:YES];
    counter = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increment) userInfo:nil repeats:YES];
    _seconds = 0;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)increment
{
    _seconds++;
    if (_seconds%10==0) {
        position.x*=1.25;
        position.y*=1.25;
    }
    _numberLabel.text = [NSString stringWithFormat:@"%i",_seconds];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    #define BallRadius 25
    #define HoleRadius 125
    
    valuex = acceleration.x * 37.0;
    valuey = -acceleration.y * 37.0;
    int newx = (int)(_ball.center.x + valuex);
    int newy = (int)(_ball.center.y + valuey);
    if (newx > self.view.frame.size.width - BallRadius)
        newx = self.view.frame.size.width - BallRadius;
    if (newx < BallRadius)
        newx = BallRadius;
    if (newy > self.view.frame.size.height - BallRadius)
        newy = self.view.frame.size.height - BallRadius;
    if (newy < BallRadius)
        newy = BallRadius;
    CGPoint newCenter = CGPointMake(newx,newy);
    _ball.center = newCenter;
    if (sqrt(powf((_ball.center.x-_hole.center.x),2)+powf((_ball.center.y-_hole.center.y),2)) > HoleRadius-BallRadius) {
        [counter invalidate];
        [self performSegueWithIdentifier:@"lose" sender:self];
       // _score.text = [NSString stringWithFormat:@"Score: 1982"];
       // if (_thescore > _thehighScore) {
       //     _thehighScore = _thescore;
       //     _highScore.text = [NSString stringWithFormat:@"Score: %i",thehighScore];
       //}
    }
}

-(void)moveHole
{
    _hole.center = CGPointMake(_hole.center.x + position.x, _hole.center.y + position.y);
    if (_hole.center.x > self.view.frame.size.width - HoleRadius || _hole.center.x < HoleRadius)
        position.x = -position.x;
    if (_hole.center.y > self.view.frame.size.height - HoleRadius || _hole.center.y < HoleRadius)
        position.y = -position.y;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
