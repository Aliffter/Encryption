//
//  ViewController2.m
//  EncryptionDemo
//
//  Created by leo on 2020/4/10.
//  Copyright © 2020年 AID. All rights reserved.
/*
 哈希(散列)函数
 特点：
 
 算法是公开的
 对相同的EncryptionDemo，得到的结果是一样的"
 对不同的EncryptionDemo，得到的结果是定长的，MD5对不同的数据进行加密，得到的结果都是 32 个字符长度的字符串
 信息摘要，信息"指纹"，是用来做数据识别的！
 不能逆推反算(重要)
 用途：
 
 版权 对文件进行散列判断该文件是否是正版或原版的
 文件完整性验证 对整个文件进行散列，比较散列值判断文件是否完整或被篡改
 密码加密，服务器并不需要知道用户真实的密码！
 
 搜索：
 如：百度搜索-->司机 厨师 老师
 或是 【老师 老司机 厨师 】
 上面两种方式搜索出来的内容是一样的
 如何判断：对搜索的每个关键字进行三列，得到三个相对应的结果，按位相加结果如果是一样的，那搜索的内容就是一样的！
 经典加密算法：MD5、SHA1、SHA512*/

#import "ViewController2.h"
#import "NSString+Hash.h"
#define saltKeyString  @"1342*&%&shlfhs390(*^^6R%@@KFGKF"
@interface ViewController2 ()
@property (weak, nonatomic) IBOutlet UITextView *oriTextView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *md5ResultTextField;
@property (weak, nonatomic) IBOutlet UITextView *sha1V;
@property (weak, nonatomic) IBOutlet UITextView *sha256V;
@property (weak, nonatomic) IBOutlet UITextView *sha512;

@property (nonatomic, strong) NSString *saltKey;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"哈希(散列)函数";
    self.textField.text = saltKeyString;
   
}
- (IBAction)check:(UIButton *)sender {
    self.saltKey = self.textField.text;  //盐key

    NSString *oriStr = self.oriTextView.text;//加密原始数据
   
    
    switch (sender.tag) {
        case 1:{
            self.md5ResultTextField.text = [oriStr md5StringWithSalt:self.saltKey];
            NSLog(@"md5_length:%lu",(unsigned long)self.md5ResultTextField.text.length);
        }
              break;
        case 2:{
            self.sha1V.text = [oriStr sha1String];
            NSLog(@"sha1_length:%lu",(unsigned long)self.sha1V.text.length);

        }
              break;
        case 3:{
            self.sha256V.text = [oriStr sha256String];
            NSLog(@"sha256_length:%lu",(unsigned long)self.sha256V.text.length);

        }
              break;
        case 4:{
            self.sha512.text = [oriStr sha512String];
            NSLog(@"sha512_length:%lu",(unsigned long)self.sha512.text.length);

        }
            break;
            
        default:
            break;
    }
    
}


@end
