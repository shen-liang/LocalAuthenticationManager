//
//  LAManager.h
//  LocalAuthenticationManager
//
//  Created by hey on 2017/12/6.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface LAManager : NSObject

+ (instancetype) sharedInstance;


/**
 The types of biometric authentication supported
 */
@property (nonatomic, assign) LABiometryType *biometryType;

/**
 设置/验证 指纹或者faceid

 @param title 标题
 @param resultBlock 返回结果
 */
-(void)validLocalAuthenticationWithTitle:(NSString *)titleStr:(void(^)(BOOL success, NSError *error))resultBlock;


/**
 设置生物识别状态

 @param userId 用户id
 @param data 资料
 @param open 状态
 */
-(void)setLocalAuthenticationWithUserID:(NSString *)userId withDomainState:(NSData *)data isOpen:(BOOL)open;

/**
 根据UserId 判断用户是否已设置

 @param userId 用户id
 @return 状态
 */
-(BOOL)getLocalAuthenticationWithUserID:(NSString *)userId;

/**
 判断生物资料（touchid/faceid）是否有修改

 @param lastData 最新的 touchuid/faceid
 @return 状态
 */
-(BOOL)isLocalAuthenticationEqualTo:(NSData *)lastData withUserID:(NSString *)userID;

/**
 是否可以使用 touchid/faceid

 @return yes or no
 */
-(BOOL)canUseLocalAuthentication;

/**
 是否可以使用LocalAuthentication

 @param resultBlock 具体状态+具体原因
 */
-(void)canUseLocalAuthentication:(void(^)(BOOL success,NSError *error))resultBlock;

@end
