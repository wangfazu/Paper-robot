//
//  MyHttPReusest.m
//  幻境
//
//  Created by mac on 17/8/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyHttPReusest.h"

@implementation MyHttPReusest
{
    NSDictionary *jsonObject;
}
- (void)getHttpRequest:(NSString *)urlString  key:(NSString *)key{
    
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 ));
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        
        NSData *aJsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        jsonObject = [NSJSONSerialization JSONObjectWithData:aJsonData
                                                     options:NSJSONReadingMutableContainers
                      
                      
                                                       error:&error];
        
        ///通知传值给，掉这个方法的的地方传回去
        [[NSNotificationCenter defaultCenter]postNotificationName:key object:nil userInfo:jsonObject];
        //////////////
        
        NSLog(@"");
    }];
    
    
    
}
@end
