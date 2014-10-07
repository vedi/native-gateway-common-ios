//
// Created by Fedor Shubin on 5/24/13.
//

#import "ProcessorEngine.h"
#import "BunchManager.h"

@interface ProcessorEngine ()
@property(nonatomic, retain) NSMutableDictionary *callHandlers;
@end

@implementation ProcessorEngine {
}

+ (ProcessorEngine *)sharedInstance {
    static ProcessorEngine *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.callHandlers = [NSMutableDictionary dictionary];
        [NSMutableDictionary dictionary];
        [NSMutableDictionary dictionary];

        [self registerProcessorForBunch:@"BunchManager" andKey:@"registerBunch" withBlock:^(NSDictionary *parameters, NSMutableDictionary *retParameters) {
            NSString *bunchClassName = parameters[@"bunch"];
            id bunch = [[NSClassFromString(bunchClassName) alloc] init];
            [[BunchManager sharedInstance] registerBunch:bunch];
        }];
    }

    return self;
}

- (NSDictionary *)proceed:(NSDictionary *)dict {
    NSString *bunch = dict[@"bunch"];
    NSString *methodName = dict[@"method"];
    NSString *dictKey = [self buildDictKey:bunch key:methodName];

    NSMutableDictionary *retParameters = [NSMutableDictionary dictionary];

    void (^callHandler)(NSDictionary *, NSDictionary *)  = self.callHandlers[dictKey];

    if (callHandler) {
        callHandler(dict[@"params"], retParameters);
    } else {
        [self logErrorWithTag: @"" andMessage: [NSString stringWithFormat:@"Cannot proceed %@", dictKey]];
    }
    return retParameters;
}

- (void)registerProcessorForBunch:(NSString *)bunch andKey:(NSString *)key withBlock:(void (^)(NSDictionary *parameters, NSMutableDictionary *retParameters))callHandler {
    [[self callHandlers] setObject:callHandler forKey:[self buildDictKey:bunch key:key]];
}

- (NSString *)buildDictKey:(NSString *)bunch key:(NSString *)key {
    return [NSString stringWithFormat:@"%@.%@", bunch, key];
}

- (void)logErrorWithTag:(NSString *)tag andMessage:(NSString *)message {
    NSLog(@"[*** ERROR ***] %@: %@", tag, message);
}

@end
