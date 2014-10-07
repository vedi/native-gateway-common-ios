//
// Created by Fedor Shubin on 5/24/13.
//

#import <Foundation/Foundation.h>

@interface ProcessorEngine : NSObject
+ (ProcessorEngine *)sharedInstance;

- (void)registerProcessorForBunch:(NSString *)bunch andKey:(NSString *)key withBlock:(void (^)(NSDictionary *parameters, NSMutableDictionary *retParameters))callHandler;

- (NSDictionary *)proceed:(NSDictionary *)parameters;
@end
