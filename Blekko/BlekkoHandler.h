//
//  BlekkoHandler.h
//  Blekko
//
//  Created by Jordan Kay on 2/11/12.
//

#import "QSInterfaceController+Async.h"

@interface BlekkoHandler : NSObject

+ (BlekkoHandler *)sharedHandler;
- (QSInterfaceControllerAsyncBlock)resultsBlockForQuery:(NSString *)query;

@end
