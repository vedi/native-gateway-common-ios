//
// Created by Fedor Shubin on 6/15/14.
//

#import <Foundation/Foundation.h>


@interface BunchManager : NSObject
+ (id)sharedInstance;

- (void)registerBunch:(NSObject *)bunch;
@end