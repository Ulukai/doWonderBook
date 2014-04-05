//
//  DWBCategoryCell.m
//  doWonderBook
//
//  Created by David Dicsöfi on 31.03.14.
//  Copyright (c) 2014 doSolutions. All rights reserved.
//

#import "DWBCategoryCell.h"
#import "DWBCategory.h"


@implementation DWBCategoryCell

@synthesize category;


- (void)setCategory:(DWBCategory *)categoryToSet
{
    category = categoryToSet;
    self.categoryImageView.image = [UIImage imageNamed:category.imageFilename];
    self.categoryLabel.text = category.displayName;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    /*
    self.categoryImageView.alpha = highlighted ? 0.75f : 1.0f;
    if (highlighted)
        [self resizeImageToWidth:180 andHeight:160];
    else
        [self resizeImageToWidth:160 andHeight:140];
     */
}

- (void)resizeImageToWidth:(CGFloat)width andHeight:(CGFloat)height
{
    UIImage *image = self.categoryImageView.image;
    
    CGSize targetSize = CGSizeMake(width,height);
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectMake(0, 0, 0, 0);
    thumbnailRect.origin = CGPointMake(0.0,0.0);
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [image drawInRect:thumbnailRect];
    
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    self.categoryImageView.image = tempImage;
}

@end
