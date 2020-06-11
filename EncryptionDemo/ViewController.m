//
//  ViewController.m
//  EncryptionDemo
//
//  Created by leo on 2020/4/10.
//  Copyright © 2020年 AID. All rights reserved.
//

/*
 .Base64编码方案
 
 Base64简单说明
 描述：Base64可以成为密码学的基石，非常重要。
 特点：可以将任意的二进制数据进行Base64编码
 结果：所有的数据都能被编码为并只用65个字符（A~Z a~z 0~9 + / =）就能表示的文本文件。
 注意：对文件进行base64编码后文件数据的变化：编码后的数据~=编码前数据的4/3，会大1/3左右。
 
 Base64编码原理和处理过程
 
 Base64编码原理
 1、将所有字符转化为ASCII码
 2、将ASCII码转化为8位二进制
 3、将二进制3个归成一组(不足3个在后边补0)共24位，再拆分成4组，每组6位
 4、统一在6位二进制前补两个0凑足8位
 5、将补0后的二进制转为十进制
 6、从Base64编码表获取十进制对应的Base64编码
 
 Base64处理过程
 1、转换的时候，将三个byte的数据，先后放入一个24bit的缓冲区中，先来的byte占高位。
 2、数据不足3byte的话，于缓冲区中剩下的bit用0补足。然后，每次取出6个bit，按照其值选择查表选择对应的字符作为编码后的输出。
 3、不断进行，直到全部输入数据转换完成。
 4、如果最后剩下两个输入数据，在编码结果后加1个“=”；
 5、如果最后剩下一个输入数据，编码结果后加2个“=”；
 6、如果没有剩下任何数据，就什么都不要加，这样才可以保证资料还原的正确性。
 在这里提供几张图结合上面的处理过程，好理解。*/


#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *oriTextView;
@property (weak, nonatomic) IBOutlet UITextView *encodeTextView;
@property (weak, nonatomic) IBOutlet UITextView *decodeTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"base64编码";
    NSString *originalString = @"12As爱壹得";
    NSString *encodeStr = [self base64Encode:originalString];
    NSString *decodeStr = [self base64DecodeString:@"MTJBc+eIseWjueW+lw=="];
    NSLog(@"base64:%@",encodeStr);
    NSLog(@"base64_decode:%@",decodeStr);
    
//   const char *ch = [@"abcABC" cStringUsingEncoding:NSASCIIStringEncoding];
//
//    for (int i = 0; i < strlen(ch); i++) {
//        printf(" --- %d", ch[i]);
//    }
}
- (IBAction)encode:(id)sender {
    self.encodeTextView.text = [self base64Encode:self.oriTextView.text];
}
- (IBAction)decode:(id)sender {
    self.decodeTextView.text = [self base64DecodeString:self.encodeTextView.text];
}
#pragma -mark - base64编码
-(NSString *)base64Encode:(NSString *)originalStr{
    NSString *tempStr = @"";
    NSData *data = [originalStr dataUsingEncoding:NSUTF8StringEncoding];
    tempStr = [data base64EncodedStringWithOptions:0];
    return tempStr;
}
-(NSString *)base64DecodeString:(NSString *)encodeStr{
    //注意：该字符串是base64编码后的字符串
    //1、转换为二进制数据（完成了解码的过程）
    NSData *data=[[NSData alloc]initWithBase64EncodedString:encodeStr options:0];
    //2、把二进制数据转换成字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end
