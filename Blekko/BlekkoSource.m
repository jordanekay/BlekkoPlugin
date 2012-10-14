//
//  BlekkoSource.m
//  Blekko
//
//  Created by Jordan Kay on 2/11/12.
//

#import "BlekkoSource.h"

static NSString *const kBlekkoID = @"Blekko";
static NSString *const kBlekkoIcon = @"BlekkoIcon";

@implementation BlekkoSource

- (NSArray *)objectsForEntry:(NSDictionary *)entry
{
    QSObject *blekko = [QSObject objectWithName:kBlekkoID];
    [blekko setIdentifier:kBlekkoID];
    [blekko setObject:kBlekkoID forType:kBlekkoID];
    [blekko setPrimaryType:NSURLPboardType];
    return [NSArray arrayWithObject:blekko];
}

- (NSImage *)iconForEntry:(NSDictionary *)entry
{
    return [QSResourceManager imageNamed:kBlekkoIcon];
}

- (void)setQuickIconForObject:(QSObject *)object
{
    [object setIcon:[QSResourceManager imageNamed:kBlekkoIcon]];
}

- (BOOL)loadIconForObject:(QSObject *)object
{
    [self setQuickIconForObject:object];
    return YES;
}

@end
