//
//  NSString+Base64.h
//  数据加密
//
//  Created by leo on 2020/4/27.
//  Copyright © 2020年 AID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)
// 对一个字符串进行base64编码,并且返回
- (NSString *)base64EncodeString;
// 对base64编码之后的字符串解码,并且返回
-(NSString *)base64DecodeString;
@end
