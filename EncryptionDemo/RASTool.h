//
//  RASTool.h
//  EncryptionDemo
//
//  Created by leo on 2020/4/27.
//  Copyright © 2020年 AID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RASTool : NSObject

+(instancetype)rasInstance;

#pragma mark - 加密
/**
 通过路径生成 SecKeyRef _publicKey（即公钥）;
 
 @param derFilePath derFilePath文件path
 */
- (void)loadPublicKeyWithPath:(NSString *)derFilePath;


/**
 生成密文：根据传入明文生成密文
 
 @param text 传入需要加密的明文
 @return 密文
 */
- (NSString *)rsaEncryptText:(NSString *)text;

- (void)loadPublicKeyWithData:(NSData *)derData;
- (NSData *)rsaEncryptData:(NSData *)data;


#pragma mark - 解密
/**
 通过路径生成 SecKeyRef _privateKey（即秘钥）;
 
 @param p12FilePath p12File的路径
 @param p12Password p12File的密码
 */
- (void)loadPrivateKeyWithPath:(NSString *)p12FilePath password:(NSString *)p12Password;

/**
 解密：根据传入的密文解密成铭文
 
 @param text 传入需要解密的密文
 @return 铭文
 */
- (NSString *)rsaDecryptText:(NSString *)text;

- (void)loadPrivateKeyWithData:(NSData *)p12Data password:(NSString *)p12Password;
- (NSData *)rsaDecryptData:(NSData *)data;

@end

