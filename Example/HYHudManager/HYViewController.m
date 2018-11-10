//
//  HYViewController.m
//  HYHudManager
//
//  Created by oceanfive on 11/11/2018.
//  Copyright (c) 2018 oceanfive. All rights reserved.
//

#import "HYViewController.h"
#import "HYHudManager.h"

@interface HYViewController ()

@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"--------------");
                [HYHudManager showText:@"text"];
        
        //        [HYHudManager showText:@"text" detailText:@"detailText"];
        
        //        [HYHudManager showText:@"text" style:HYHudTextStyleBlackWhite];
        
        //        [HYHudManager showText:@"text" detailText:@"detailText" style:HYHudTextStyleBlackWhite];
        
        
        // ----------------
        
        //        [HYHudManager showTextNearBottom:@"text"];
        
        //        [HYHudManager showTextNearBottom:@"text" detailText:@"detailText"];
        
        //        [HYHudManager showTextNearBottom:@"text" detailText:@"detailText" style:HYHudStyleDark];
        
        //        [HYHudManager showText:@"text" image:[UIImage imageNamed:@"Checkmark"] style:HYHudStyleDark];
        
        //        [HYHudManager showLoadingToView:self.view];
        
        //        [HYHudManager showLoadingToView:self.view text:@"laod"];
        
        //        [HYHudManager showLoadingToView:self.view text:@"loading1" style:HYHudStyleDark];
        //
        //       [HYHudManager showLoadingToView:self.view text:@"loading2" style:HYHudStyleDark];
        //
        //        [HYHudManager showLoadingToView:self.view text:@"loading3" style:HYHudStyleDark];
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //            [HYHudManager hideLoading:self.view];
        //        });
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
