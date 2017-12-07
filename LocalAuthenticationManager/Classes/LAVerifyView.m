//
//  LAVerifyView.m
//  Pods
//
//  Created by hey on 2017/12/6.
//

#import "LAVerifyView.h"
#import <Masonry/Masonry.h>
#import "UIImage+STint.h"

@interface LAVerifyView ()


@property (nonatomic , strong) UIButton *fingerVerifyButton;

@property (nonatomic , strong) UIButton *changeAccountButton;

@end

@implementation LAVerifyView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
        [self createConstrains];
        [self setFingerViewInfo];
    }
    return self;
}

-(void)fingerVerifyButtonAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(LAVerifyViewVerify)]) {
        [_delegate LAVerifyViewVerify];
    }
}

-(void)changeAccountButtonAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(LAVerifyViewChangeAccount)]) {
        [_delegate LAVerifyViewChangeAccount];
    }
}

-(void)setFingerViewInfo
{
    _nickNameLabel.text = @"--";
}

-(void)createViews
{
    UIColor *redColor = [UIColor redColor];
    
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 30;
    [self addSubview:_headerImageView];
    
    _nickNameLabel = [[UILabel alloc] init];
    _nickNameLabel.textColor = [UIColor darkGrayColor];
    _nickNameLabel.font = [UIFont systemFontOfSize:16];
    _nickNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nickNameLabel];
    
    _fingerVerifyButton = [[UIButton alloc] init];
    [_fingerVerifyButton setImage:[UIImage getRdImageResourceBundleWithName:@"fingerprint"] forState:UIControlStateNormal];
    [_fingerVerifyButton addTarget:self action:@selector(fingerVerifyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_fingerVerifyButton];
    
    _verifyTipLabel = [[UILabel alloc] init];
    _verifyTipLabel.font = [UIFont systemFontOfSize:14];
    _verifyTipLabel.text = @"点击进行指纹解锁";
    _verifyTipLabel.textColor = redColor;
    _verifyTipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_verifyTipLabel];
    
    _changeAccountButton = [[UIButton alloc] init];
    [_changeAccountButton addTarget:self action:@selector(changeAccountButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_changeAccountButton setTitle:@"登录其他账户" forState:UIControlStateNormal];
    [_changeAccountButton setTitleColor:redColor forState:UIControlStateNormal];
    [_changeAccountButton setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_changeAccountButton];
}

-(void)createConstrains
{
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.equalTo(self).offset(170/2);
        make.centerX.equalTo(self);
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    
    [_fingerVerifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    [_verifyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_fingerVerifyButton.mas_bottom).offset(17);
    }];
    
    [_changeAccountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-30);
        make.left.right.equalTo(self);
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
