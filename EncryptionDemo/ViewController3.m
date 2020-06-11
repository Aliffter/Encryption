//
//  ViewController3.m
//  EncryptionDemo
//
//  Created by leo on 2020/4/27.
//  Copyright © 2020年 AID. All rights reserved.
//

#import "ViewController3.h"
#import "NSString+AES.h"
static NSString * const saltKeyString = @"1342*&%&shlfhs390(*^^6R%@@KFGKF";

@interface ViewController3 ()
@property (weak, nonatomic) IBOutlet UITextView *oriV;
@property (weak, nonatomic) IBOutlet UITextField *keyStr;
@property (weak, nonatomic) IBOutlet UITextView *resultStr;
@property (weak, nonatomic) IBOutlet UITextView *decodeStr;
@property (weak, nonatomic) IBOutlet UITextView *desStr;
@property (weak, nonatomic) IBOutlet UITextView *desdecodeStr;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keyStr.text = saltKeyString;
    self.title = @"对称加密";
    NSString *enStr = [NSString encodeDesWithString:self.title];
    NSString *deStr = [NSString decodeDesWithString:enStr];
    NSLog(@"des加密:%@",enStr) ;
    
    NSLog(@"des解密:%@",deStr) ;

}

- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 1) {
        self.resultStr.text = [self.oriV.text aes256_encrypt:self.keyStr.text];
        NSLog(@"1 ---- %@",[self.oriV.text aes256_encrypt:self.keyStr.text]);

    }else{
        self.decodeStr.text = [self.resultStr.text aes256_decrypt:self.keyStr.text];
        NSLog(@"2 ---- %@",[self.resultStr.text aes256_decrypt:self.keyStr.text]);
    }
}
- (IBAction)desButtonClick:(UIButton *)sender {
    if (sender.tag == 1) {
        self.desStr.text = [NSString encodeDesWithString:self.oriV.text];
        NSLog(@"3 ---- %@",self.desStr.text);

    }else{
        self.desdecodeStr.text = [NSString decodeDesWithString:self.desStr.text];
        NSLog(@"4 ---- %@",self.desdecodeStr.text);

    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
