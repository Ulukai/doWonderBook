//
//  DWBCategory.m
//  doWonderBook
//
//  Created by David Dicsöfi on 22.02.14.
//  Copyright (c) 2014 doSolutions. All rights reserved.
//

#import "DWBCategory.h"


@implementation DWBCategory

- (instancetype)initWithCSVRow:(NSArray *)row
{
    // Validate CSV row
    if([self isValid:row]) {
        
        self.displayName   = row[0];
        self.imageFilename = row[1];
        
        NSString *order    = row[2];
        self.order         = [NSNumber numberWithInt:[order intValue]];
        
        return self;
    }
    
    return nil;
}

- (BOOL)isValid:(NSArray *)row
{
    if(!row || row.count < 3) {
        return NO;
    }
    
    return YES;
}

- (NSArray *)toCSVRow
{
    NSMutableArray *result = [NSMutableArray new];
    
    [result addObject:[self getCSVValueForProperty:self.displayName]];
    [result addObject:[self getCSVValueForProperty:self.imageFilename]];
    [result addObject:[self getCSVValueForProperty:self.order]];
    
    return result;
}

- (id)getCSVValueForProperty:(id)property
{
    if(property)
        return property;
    else
        return @"";
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy) {
        [copy setDisplayName:[self.displayName copyWithZone:zone]];
        [copy setImageFilename:[self.imageFilename copyWithZone:zone]];
        [copy setOrder:[self.order copyWithZone:zone]];
    }
    
    return copy;
}

- (NSUInteger)hash
{
    return self.displayName.hash;
}

- (BOOL)isEqual:(id)object
{
    if([object isKindOfClass:[DWBCategory class]]) {
        return [((DWBCategory *)object).displayName isEqualToString:self.displayName];
    }
    
    return NO;
}

@end
