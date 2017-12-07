//
//  LAManager.m
//  LocalAuthenticationManager
//
//  Created by hey on 2017/12/6.
//

#import "LAManager.h"

#define LAUserDefaultKey @"LAUserDefaultKey"

@implementation LAManager

static LAManager *sharedInstance = nil;

+ (instancetype) sharedInstance
{
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[LAManager alloc] init];
        
    });
    return sharedInstance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        LAContext *context= [[LAContext alloc] init];
        NSError* errorMessage = nil;
        [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&errorMessage];
        _biometryType = context.biometryType;
    }
    return self;
}

-(BOOL)canUseLocalAuthentication
{
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        //系统版本低于8.0，则无法使用touch id功能
        return NO;
    }
    LAContext *context= [[LAContext alloc] init];
    NSError* errorMessage = nil;
    BOOL isAvailable = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&errorMessage];
    return isAvailable;
}

-(void)canUseLocalAuthentication:(void (^)(BOOL, NSError *))resultBlock
{
    BOOL isAvailable;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        //系统版本低于8.0，则无法使用touch id功能
        isAvailable = NO;
    }
    LAContext *context= [[LAContext alloc] init];
    NSError* errorMessage = nil;
    isAvailable = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&errorMessage];
    resultBlock(isAvailable,errorMessage);
}

-(void)validLocalAuthenticationWithTitle:(NSString *)titleStr :(void (^)(BOOL, NSError *))resultBlock
{
    LAContext *context= [[LAContext alloc] init];
    NSString* result = titleStr;
    context.localizedFallbackTitle = @"";
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
        resultBlock(success,error);
    }];
}

-(void)setLocalAuthenticationWithUserID:(NSString *)userId withDomainState:(NSData *)data isOpen:(BOOL)open
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *lainfo = @{@"ladata":data,@"isOpen":[NSString stringWithFormat:@"%@ld",open]};
    [userDefaults setObject:lainfo forKey:[NSString stringWithFormat:@"%@-%@",LAUserDefaultKey,userId]];
}

-(BOOL)getLocalAuthenticationWithUserID:(NSString *)userId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *lainfo = [userDefaults objectForKey:[NSString stringWithFormat:@"%@-%@",LAUserDefaultKey,userId]];
    if (lainfo != nil) {
        return  [[lainfo objectForKey:@"isOpen"] boolValue];
    }
    return NO;
}

-(BOOL)isLocalAuthenticationEqualTo:(NSData *)lastData withUserID:(NSString *)userID
{
    BOOL isEqual;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *lainfo = [userDefaults objectForKey:[NSString stringWithFormat:@"%@-%@",LAUserDefaultKey,userID]];
    NSData *data = [lainfo objectForKey:@"ladata"];
    
    isEqual = [lastData isEqualToData:data];
    
    return isEqual;
}

@end
