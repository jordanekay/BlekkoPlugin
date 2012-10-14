//
//  BlekkoHandler.m
//  Blekko
//
//  Created by Jordan Kay on 2/11/12.
//  Copyright (c) 2012 Laughing Sprout. All rights reserved.
//

#import "BlekkoHandler.h"

#define MAX_COUNT 100

static NSString *const kBlekkoURL  = @"http://blekko.com/ws/?q=%@+/json+/ps=100&source=1e04582f";
static NSString *const kResultsKey = @"RESULT";

static NSString *const kURLKey   = @"url";
static NSString *const kTitleKey = @"url_title";

@implementation BlekkoHandler

+ (BlekkoHandler *)sharedHandler
{
    static dispatch_once_t once;
    static BlekkoHandler *sharedHandler;
    dispatch_once(&once, ^{ 
        sharedHandler = [[self alloc] init]; 
    });
    return sharedHandler;
}

- (QSInterfaceControllerAsyncBlock)resultsBlockForQuery:(NSString *)query
{
    return [[^{
        return [self _resultsForQuery:query];
    } copy] autorelease];
}

- (NSArray *)_resultsForQuery:(NSString *)query
{
    NSString *parameter = [query stringByReplacing:@" " with:@"+"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kBlekkoURL, parameter]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]; 
    NSArray *resultDictionaries = [resultsDictionary objectForKey:kResultsKey];
    if([resultDictionaries count] > MAX_COUNT) {
        resultDictionaries = [resultDictionaries subarrayWithRange:NSMakeRange(0, MAX_COUNT)];
    }
    
    NSMutableArray *results = [NSMutableArray array];
    for(NSDictionary *d in resultDictionaries) {
        NSString *name = [self _displayTitleForTitle:[d objectForKey:kTitleKey]];
        NSString *value = [d objectForKey:kURLKey];
        QSObject *result = [QSObject objectWithType:NSURLPboardType value:value name:name];
        [results addObject:result];
    }
    
    return results;
}

- (NSString *)_displayTitleForTitle:(NSString *)title
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<.*?>" options:NSRegularExpressionCaseInsensitive error:nil];
	NSString *displayTitle = [regex stringByReplacingMatchesInString:title options:0 range:NSMakeRange(0, [title length]) withTemplate:@""];
    return displayTitle;
}

@end
