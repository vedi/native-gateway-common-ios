//
// Created by Shubin Fedor on 04/10/14.
//

#import <Foundation/Foundation.h>


@interface DictJsonSerializer : NSObject
+ (const char *)serialize:(NSDictionary *)dict;

+ (NSDictionary *)deserialize:(const char *)str;
@end