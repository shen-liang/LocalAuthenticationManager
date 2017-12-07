//
//  RDViewController.m
//  LocalAuthenticationManager
//
//  Created by 490712370@qq.com on 12/06/2017.
//  Copyright (c) 2017 490712370@qq.com. All rights reserved.
//

#import "RDViewController.h"
#import <LocalAuthenticationManager/LAManager.h>
#import <LocalAuthenticationManager/LAVerifyViewController.h>

@interface RDViewController ()

@end

@implementation RDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)validButton:(id)sender {
    
    LAVerifyViewController *dvc = [[LAVerifyViewController alloc] init];
    
    [self presentViewController:dvc animated:YES completion:^{
        
    }];
    
}
@end
