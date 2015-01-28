//
//  MNKAccelViewController.h
//  followme
//
//  Created by Jake Jermanok on 6/16/14.
//  Copyright (c) 2014 Manok Inc. All rights reserved.
//

#import "MNKViewController.h"

@interface MNKAccelViewController : UIViewController <UIAccelerometerDelegate> {
    float valuex;
    float valuey;
    CGPoint position;
    NSTimer *counter;
}

@property (nonatomic) IBOutlet UIImageView *ball;
@property (nonatomic) IBOutlet UIImageView *hole;
@property (nonatomic) int seconds;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (nonatomic) int thescore;
@property (nonatomic) int theHighScore;

@end
