//
//  RASTool.m
//  EncryptionDemo
//
//  Created by leo on 2020/4/27.
//  Copyright © 2020年 AID. All rights reserved.
//

#import "RASTool.h"

@interface RASTool () {
    SecKeyRef _publicKey;
    SecKeyRef _privateKey;
}
@end

@implementation RASTool

+(instancetype)rasInstance
{
    static RASTool *ras = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ras = [[RASTool alloc] init];
    });
    return ras;
}

- (void)dealloc {
    if (nil != _publicKey) {
        CFRelease(_publicKey);
    }
    
    if (nil != _privateKey) {
        CFRelease(_privateKey);
    }
}


#pragma mark - 加密
- (void)loadPublicKeyWithPath:(NSString *)derFilePath {
    NSData *derData = [[NSData alloc] initWithContentsOfFile:derFilePath];
    if (derData.length > 0) {
        [self loadPublicKeyWithData:derData];
    } else {
        NSLog(@"load public key fail with path: %@", derFilePath);
    }
}

- (void)loadPublicKeyWithData:(NSData *)derData {
    SecCertificateRef myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)derData);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
    SecTrustResultType trustResult;
    
    if (status == noErr) {
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    
    SecKeyRef securityKey = SecTrustCopyPublicKey(myTrust);
    CFRelease(myCertificate);
    CFRelease(myPolicy);
    CFRelease(myTrust);
    _publicKey = securityKey;
}

- (NSString *)rsaEncryptText:(NSString *)text {
    NSData *encryptedData = [self rsaEncryptData:[text dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *base64EncryptedString = [encryptedData base64EncodedStringWithOptions:0];
    return base64EncryptedString;
}

- (NSData *)rsaEncryptData:(NSData *)data {
    SecKeyRef key = _publicKey;
    
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    size_t blockSize = cipherBufferSize - 11;
    size_t blockCount = (size_t)ceil([data length] / (double)blockSize);
    
    NSMutableData *encryptedData = [[NSMutableData alloc] init] ;
    for (int i = 0; i < blockCount; i++) {
        size_t bufferSize = MIN(blockSize,[data length] - i * blockSize);
        NSData *buffer = [data subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key,
                                        kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length],
                                        cipherBuffer,
                                        &cipherBufferSize);
        if (status == noErr) {
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer
                                                            length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
        } else {
            if (cipherBuffer) {
                free(cipherBuffer);
            }
            
            return nil;
        }
    }
    
    if (cipherBuffer){
        free(cipherBuffer);
    }
    
    return encryptedData;
}

#pragma mark - 解密
- (void)loadPrivateKeyWithPath:(NSString *)p12FilePath password:(NSString *)p12Password {
    NSData *data = [NSData dataWithContentsOfFile:p12FilePath];
    
    if (data.length > 0) {
        [self loadPrivateKeyWithData:data password:p12Password];
    } else {
        NSLog(@"load private key fail with path: %@", p12FilePath);
    }
}

- (void)loadPrivateKeyWithData:(NSData *)p12Data password:(NSString *)p12Password {
    SecKeyRef privateKeyRef = NULL;
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    
    [options setObject:p12Password forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef)p12Data,
                                             (__bridge CFDictionaryRef)options,
                                             &items);
    
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict,
                                                                          kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        
        if (securityError != noErr) {
            privateKeyRef = NULL;
        }
    }
    CFRelease(items);
    _privateKey = privateKeyRef;
    
    
}

- (NSString *)rsaDecryptText:(NSString *)text {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:text options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *decryptData = [self rsaDecryptData:data];
    NSString *result = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
    return result;
}

- (NSData *)rsaDecryptData:(NSData *)data {
    SecKeyRef key = _privateKey;
    
    size_t cipherLen = [data length];
    void *cipher = malloc(cipherLen);
    
    [data getBytes:cipher length:cipherLen];
    size_t plainLen = SecKeyGetBlockSize(key) - 12;
    
    void *plain = malloc(plainLen);
    OSStatus status = SecKeyDecrypt(key, kSecPaddingPKCS1, cipher, cipherLen, plain, &plainLen);
    
    if (status != noErr) {
        return nil;
    }
    
    NSData *decryptedData = [[NSData alloc] initWithBytes:(const void *)plain length:plainLen];
    
    return decryptedData;
}

@end
