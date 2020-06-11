//
//  NSString+AES.h
//  数据加密
//
//  Created by leo on 2020/4/10.
//  Copyright © 2020年 AID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

#import "NSData+AES.h"
@interface NSString (AES)
-(NSString *) aes256_encrypt:(NSString *)key;
-(NSString *) aes256_decrypt:(NSString *)key;

+ (NSString *)encodeDesWithString:(NSString *)str;
+ (NSString *)decodeDesWithString:(NSString *)str;
@end
