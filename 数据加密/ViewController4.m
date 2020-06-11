//
//  ViewController4.m
//  数据加密
//
//  Created by leo on 2020/4/27.
//  Copyright © 2020年 AID. All rights reserved.
//

#import "ViewController4.h"
#import <CommonCrypto/CommonCrypto.h>
#import "RASTool.h"
#import "RSAHandler.h"
@interface ViewController4 ()
@property (weak, nonatomic) IBOutlet UITextView *oriV;
@property (weak, nonatomic) IBOutlet UITextView *resultV;
@property (weak, nonatomic) IBOutlet UITextView *decodeV;

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    //需要开启keychainSharing权限
    self.title = @"非对称加密RSA";
    NSString *publicPath = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *privatePath = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];

    [[RASTool rasInstance] loadPublicKeyWithPath:publicPath];

    [[RASTool rasInstance] loadPrivateKeyWithPath:privatePath password:@"aid123"]; //p12 文件密码
    
    [self rsaHandleTest];

}

-(void)rsaHandleTest{
    /*- (BOOL)importKeyWithType:(KeyType)type andPath:(NSString*)path;
     - (BOOL)importKeyWithType:(KeyType)type andkeyString:(NSString *)keyString;
     */
    NSString *publicPath = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *privatePath = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];

    RSAHandler *handler = [[RSAHandler alloc] init];
    BOOL bl1= [handler importKeyWithType:KeyTypePublic andPath:publicPath];
    BOOL bl2 = [handler importKeyWithType:KeyTypePrivate andkeyString:privatePath];
    
    NSString *resStr = [handler encryptWithPublicKey:self.oriV.text];
    NSLog(@"resStr:%@",resStr);
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 1) {
        
        NSString *encryptString = [[RASTool rasInstance] rsaEncryptText:self.oriV.text];
        self.resultV.text = encryptString;
        NSLog(@"加密结果为：%@", encryptString);
    }else{
        NSString *string = [[RASTool rasInstance] rsaDecryptText:self.resultV.text];
        self.decodeV.text = string;
        NSLog(@"解密结果为：%@", string);

    }
    
}


@end
