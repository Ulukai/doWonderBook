//
//  DWBPage.h
//  doWonderBook
//
//  Created by David Dicsöfi on 22.02.14.
//  Copyright (c) 2014 doSolutions. All rights reserved.
//

@class DWBCategory;


@interface DWBPage : NSObject

@property (nonatomic, strong) NSString    *imageFilename;
@property (nonatomic, strong) NSNumber    *order;
@property (nonatomic, strong) NSURL       *soundFileURL;
@property (nonatomic, strong) NSString    *soundFileTitle;
@property (nonatomic, strong) NSString    *text;
@property (nonatomic, strong) DWBCategory *category;
@property (nonatomic, strong) NSString    *categoryName;
@property (nonatomic)         BOOL        custom;
@property (nonatomic)         BOOL        initWithWizard;

- (instancetype)initWithCSVRow:(NSArray *)row;
- (NSArray *)toCSVRow;
- (void)setImageToImageView:(UIImageView *)view asThumbnail:(BOOL)thumbnail;

@end
