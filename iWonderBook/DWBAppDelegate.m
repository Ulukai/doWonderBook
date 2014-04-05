//
//  DWBAppDelegate.m
//  doWonderBook
//
//  Created by David Dicsöfi on 22.02.14.
//  Copyright (c) 2014 doSolutions. All rights reserved.
//

#import "DWBAppDelegate.h"
#import "DWBCategory.h"
#import "DWBPage.h"
#import "CHCSVParser.h"


@implementation DWBAppDelegate

NSMutableDictionary *gCategories2Pages;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Init the application data / global variables
    [self initApplicationData];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)initApplicationData
{
    //
    // Load the application data from the CSV-Files and create a map Category->Pages
    // Notes:
    // - Empty categories are not part of the map
    //
    
    // Load categories in a Map[Name->Category], so we can assign the pages to their category by name
    NSString *categoryFilePath       = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"csv"];
    NSMutableDictionary *categoryMap = [self parseCategoryCSVFileAtFilePath:categoryFilePath];
    
    // Load pages
    NSString *pageFilePath = [[NSBundle mainBundle] pathForResource:@"Page" ofType:@"csv"];
    NSMutableArray *pages  = [self parsePageCSVFileAtFilePath:pageFilePath];
    
    
    // Fill the map with the provided data
    //
    gCategories2Pages = [NSMutableDictionary new];
    for (DWBPage *page in pages) {
        
        // Assign the category to the page
        if(page.categoryName) {
            page.category = categoryMap[page.categoryName];
        }
        
        // Add the current page to the collection of pages in his category
        if(page.category) {
            NSMutableArray *pagesInCategory = gCategories2Pages[page.category];
            if(!pagesInCategory) {
                pagesInCategory = [NSMutableArray new];
                gCategories2Pages[page.category] = pagesInCategory;
            }
            [pagesInCategory addObject:page];
        }
    }
    
    
    // Sort by order
    //
    NSSortDescriptor *byOrderDesc = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES];
    for (NSMutableArray * pages in gCategories2Pages.allValues) {
        [pages sortUsingDescriptors:@[byOrderDesc]];
    }
}

- (NSMutableArray *)parsePageCSVFileAtFilePath:(NSString *)pageFilePath
{
    NSMutableArray *pages = [NSMutableArray array];
    NSArray *pageRows = [NSArray arrayWithContentsOfCSVFile:pageFilePath];
    for (NSArray *row in pageRows) {
        DWBPage *page = [[DWBPage alloc] initWithCSVRow:row];
        if(page) {
            [pages addObject:page];
        }
    }
    
    return pages;
}

- (NSMutableDictionary *)parseCategoryCSVFileAtFilePath:(NSString *)categoryFilePath
{
    NSMutableDictionary *categoryMap = [NSMutableDictionary new];
    NSArray *categoryRows            = [NSArray arrayWithContentsOfCSVFile:categoryFilePath];
    for (NSArray *row in categoryRows) {
        DWBCategory *category = [[DWBCategory alloc] initWithCSVRow:row];
        if(category) {
            categoryMap[category.displayName] = category;
        }
    }
    
    return categoryMap;
}


#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)applicationDocumentsDirectoryAsString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    
    return documentsDirectory;
}

- (NSString *)customPageFilePath
{
    return [self.applicationDocumentsDirectoryAsString stringByAppendingPathComponent:@"CustomPages.csv"];
}

@end
