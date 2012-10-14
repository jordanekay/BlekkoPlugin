//
//  BlekkoAction.m
//  Blekko
//
//  Created by Jordan Kay on 2/11/12.
//

#import "BlekkoAction.h"
#import "BlekkoHandler.h"

@implementation BlekkoAction

- (QSObject *)search:(QSObject *)service forQuery:(QSObject *)query
{
    NSString *queryString = [query name];
    NSPasteboard *findPboard = [NSPasteboard pasteboardWithName:NSFindPboard];
    [findPboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
    [findPboard setString:queryString forType:NSStringPboardType];
    
    QSInterfaceControllerAsyncBlock arrayBlock = [[BlekkoHandler sharedHandler] resultsBlockForQuery:queryString];
    [[QSReg preferredCommandInterface] showArrayAsyncFromBlock:arrayBlock];
    
    return nil;
}

- (NSArray *)validIndirectObjectsForAction:(NSString *)action directObject:(QSObject *)service 
{
    NSString *value = [[NSPasteboard pasteboardWithName:NSFindPboard] stringForType:NSStringPboardType] ?: @"";
    NSArray *query = [NSArray arrayWithObject:[QSObject textProxyObjectWithDefaultValue:value]]; 
    return query;
}

@end
