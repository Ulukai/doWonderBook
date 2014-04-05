//
//  DWBPage.m
//  doWonderBook
//
//  Created by David Dicsöfi on 22.02.14.
//  Copyright (c) 2014 doSolutions. All rights reserved.
//

#import "DWBPage.h"
#import "AssetsLibrary/AssetsLibrary.h"


@implementation DWBPage

- (instancetype)initWithCSVRow:(NSArray *)row
{
    if([self isValid:row]) {
        
        self.text          = row[0];
        self.imageFilename = row[1];
        self.categoryName  = row[2];
        
        NSString *order = row[3];
        self.order      = [NSNumber numberWithInt:[order intValue]];
        
        NSString *soundFileURL = row[4];
        self.soundFileURL      = [NSURL URLWithString:soundFileURL];
        
        self.soundFileTitle = row[5];
        
        NSString *isCustom = row[6];
        self.custom        = [isCustom boolValue];
        
        NSString *isInitWithWizard = row[7];
        self.initWithWizard        = [isInitWithWizard boolValue];
        
        return self;
    }
    
    return nil;
}

- (BOOL)isValid:(NSArray *)row
{
    if(!row || row.count < 8) {
        return NO;
    }
    
    return YES;
}

- (NSArray *)toCSVRow
{
    NSMutableArray *result = [NSMutableArray new];
    
    [result addObject:[self getCSVValueForProperty:self.text]];
    [result addObject:[self getCSVValueForProperty:self.imageFilename]];
    [result addObject:[self getCSVValueForProperty:self.categoryName]];
    [result addObject:[self getCSVValueForProperty:self.order]];
    [result addObject:[self getCSVValueForProperty:self.soundFileURL.relativeString]];
    [result addObject:[self getCSVValueForProperty:self.soundFileTitle]];
    [result addObject:[self getCSVValueForProperty:self.custom ? @"TRUE" : @"FALSE"]];
    [result addObject:[self getCSVValueForProperty:self.initWithWizard ? @"TRUE" : @"FALSE"]];
    
    return result;
}

- (id)getCSVValueForProperty:(id)property
{
    if(property)
        return property;
    else
        return @"";
}

- (void)setImageToImageView:(UIImageView *)view asThumbnail:(BOOL)thumb
{
    // 1. Try: imageFilename
    view.image = [UIImage imageNamed:self.imageFilename];
    
    
    if(!view.image) {
        // 2.Try: Image from library
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *asset)
        {
            CGImageRef iref = [[asset defaultRepresentation] fullResolutionImage];
            if (thumb)
                iref = [asset thumbnail];
            
            if (iref)
                view.image = [UIImage imageWithCGImage:iref];
        };
        
        ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror) {
            // Fallback image
            view.image = [UIImage imageNamed:@"noimage.png"];
            NSLog(@"ERROR XP55X SETTING IMAGE - %@",[myerror localizedDescription]);
        };
        
        NSURL *chosenImageURL = [NSURL URLWithString:self.imageFilename];
        if (chosenImageURL) {
            ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
            [assetslibrary assetForURL:chosenImageURL
                           resultBlock:resultblock
                          failureBlock:failureblock];
        }
    }
}

@end
