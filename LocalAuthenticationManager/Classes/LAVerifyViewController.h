//
//  LAVerifyViewController.h
//  Pods
//
//  Created by hey on 2017/12/6.
//

#import <UIKit/UIKit.h>

@protocol LAVerifyViewControllerDelegate <NSObject>

/**
 change account
 */
-(void)LAVerifyViewControllerChangeAccount;

@end

@interface LAVerifyViewController : UIViewController

@property (nonatomic, strong) NSString *nickName;

@property (nonatomic, strong) UIImage *headerImage;

@property (nonatomic, assign) id<LAVerifyViewControllerDelegate>delegate;

@end
