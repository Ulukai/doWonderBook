//
//  DWBCollectionViewController.h
//  doWonderBook
//
//  Created by David Dicsöfi on 31.03.14.
//  Copyright (c) 2014 doSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXReorderableCollectionViewFlowLayout.h"

@interface DWBCollectionViewController : UICollectionViewController<LXReorderableCollectionViewDataSource, LXReorderableCollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *categories;

@end
