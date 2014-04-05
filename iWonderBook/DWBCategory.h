//
//  DWBCategory.h
//  doWonderBook
//
//  Created by David Dicsöfi on 22.02.14.
//  Copyright (c) 2014 doSolutions. All rights reserved.
//


@interface DWBCategory : NSObject<NSCopying>

@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *imageFilename;
@property (nonatomic, strong) NSNumber *order;

- (instancetype)initWithCSVRow:(NSArray *)row;
- (NSArray *)toCSVRow;

@end
