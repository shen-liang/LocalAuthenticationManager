//
//  LAVerifyView.h
//  Pods
//
//  Created by hey on 2017/12/6.
//

#import <UIKit/UIKit.h>

@protocol LAVerifyViewDelegate <NSObject>

/**
 切换用户
 */
-(void)LAVerifyViewChangeAccount;

/**
 验证
 */
-(void)LAVerifyViewVerify;

@end

@interface LAVerifyView : UIView

@property (nonatomic , strong) UILabel *verifyTipLabel;

@property (nonatomic , strong)UIImageView *headerImageView;

@property (nonatomic , strong) UILabel *nickNameLabel;

@property (nonatomic, weak) id<LAVerifyViewDelegate>delegate;

@end
