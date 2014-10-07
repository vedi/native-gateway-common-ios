//
// Created by Shubin Fedor on 04/10/14.
//

#import "DictJsonSerializer.h"


@implementation DictJsonSerializer {
}

+ (const char *)serialize: (NSDictionary *)dict {
    NSError* error = nil;
    NSData *retJsonParamsData = [NSJSONSerialization
            dataWithJSONObject:dict
                       options:NSJSONWritingPrettyPrinted
                         error:&error];

    if (error != nil) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    }

    NSString *retJsonParamsStr = [[NSString alloc] initWithData:retJsonParamsData
                                                       encoding:NSUTF8StringEncoding];

    if (retJsonParamsStr == nil) {
        return nil;
    }

    const char *result = [retJsonParamsStr UTF8String];

    char* res = (char*)malloc(strlen(result) + 1);
    strcpy(res, result);

    return res;
}

+ (NSDictionary *)deserialize: (const char *)str {

    NSString *jsonParamsStr = [[NSString alloc] initWithUTF8String: str];

    NSError* error = nil;
    NSDictionary *result = [NSJSONSerialization
            JSONObjectWithData:[jsonParamsStr dataUsingEncoding:NSUTF8StringEncoding]
                       options:(NSJSONReadingOptions) kNilOptions
                         error:&error];

    if (error != nil) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return nil;
    }

    return result;
}

@end