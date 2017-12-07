//
//  LAVerifyViewController.m
//  Pods
//
//  Created by hey on 2017/12/6.
//

#import "LAVerifyViewController.h"
#import "LAManager.h"
#import "LAVerifyView.h"
#import "UIImage+STint.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface LAVerifyViewController ()<LAVerifyViewDelegate,UIAlertViewDelegate>

@end

@implementation LAVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    LAVerifyView *fingerView = [[LAVerifyView alloc] initWithFrame:self.view.frame];
    fingerView.delegate = self;
    if (_nickName == nil) {
        fingerView.nickNameLabel.text = @"nickname";
    }
    if (_headerImage == nil) {
        fingerView.headerImageView.image = [UIImage getRdImageResourceBundleWithName:@"account_pic_head"];
    }
    [self.view addSubview:fingerView];
    
    if ([LAManager sharedInstance].biometryType == LABiometryTypeFaceID) {
        fingerView.verifyTipLabel.text = @"点击进行Face ID解锁";
    }
    
    [self LAVerifyViewVerify];
}

#pragma mark--LAVerifyViewDelegate
-(void)LAVerifyViewVerify
{
    NSString *title = @"验证指纹";
    
    [[LAManager sharedInstance] validLocalAuthenticationWithTitle:title :^(BOOL success, NSError *error) {
       
        if (success) {
            //验证成功
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error.code == LAErrorUserFallback) {
                    NSLog(@"User tapped Enter Password");
                    
                    
                } else if (error.code == LAErrorUserCancel) {
                    NSLog(@"User tapped Cancel");
                    //                     [SVProgressHUD showImage:nil status:@"用户取消指纹识别"];
                }
                else if (error.code == LAErrorTouchIDNotEnrolled)
                {
                    NSString *errorMsg = @"未在设置中录入指纹";
                    if ([LAManager sharedInstance].biometryType == LABiometryTypeFaceID) {
                        errorMsg = @"未在设置中录入Face ID";
                    }
                    [SVProgressHUD showErrorWithStatus:errorMsg];
                }
                else if (error.code == LAErrorTouchIDLockout)
                {
                    NSString *errorMsg = @"Touch ID 无法识别您的指纹";
                    if ([LAManager sharedInstance].biometryType == LABiometryTypeFaceID) {
                        errorMsg = @"Face ID无法识别";
                    }
                    [SVProgressHUD showErrorWithStatus:errorMsg];
                }
                else {
                    NSString *errorMsg = @"指纹不匹配";
                    if ([LAManager sharedInstance].biometryType == LABiometryTypeFaceID) {
                        errorMsg = @"Face ID不匹配";
                    }
                    [SVProgressHUD showErrorWithStatus:errorMsg];
                }
                });
                
        }
        
    }];
}

-(void)LAVerifyViewChangeAccount
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"登录其他账户，您需要重新登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(LAVerifyViewChangeAccount)]) {
            [_delegate LAVerifyViewControllerChangeAccount];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
