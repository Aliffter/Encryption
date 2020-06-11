//
//  NSString+Hash.h
//  EncryptionDemo
//
//  Created by leo on 2020/4/10.
//  Copyright © 2020年 AID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)
#pragma mark - 散列函数

- (NSString *)md5String;
- (NSString *)md5StringWithSalt:(NSString *)saltString;
- (NSString *)hmacMD5StringWithKey:(NSString *)key;

- (NSString *)sha1String;
- (NSString *)sha256String;
- (NSString *)sha512String;

@end
