//
//  NSData+AES.h
//  EncryptionDemo
//
//  Created by leo on 2020/4/27.
//  Copyright © 2020年 AID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSData (AES)
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end
