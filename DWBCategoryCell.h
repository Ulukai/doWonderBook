//
//  DWBCategoryCell.h
//  doWonderBook
//
//  Created by David Dicsöfi on 31.03.14.
//  Copyright (c) 2014 doSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DWBCategory;



@interface DWBCategoryCell : UICollectionViewCell


@property (strong, nonatomic) DWBCategory *category;

@property (strong, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;


@end
