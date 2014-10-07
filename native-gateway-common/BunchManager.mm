//
// Created by Fedor Shubin on 6/15/14.
//

#import "BunchManager.h"


@interface BunchManager ()
@property(nonatomic, retain) NSMutableArray *bunches;
@end

@implementation BunchManager {

}

+ (id)sharedInstance {
    static BunchManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _bunches = [NSMutableArray array];
    }

    return self;
}

- (void)registerBunch:(NSObject *)bunch {
    [self.bunches addObject:bunch];
}


@end