//
//  AppDelegate.m
//  BookCollection
//
//  Created by Trevor Bliss on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "BookTabVC.h"
#import "Book.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize bookCollection = _bookCollection;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set default settings for Barcode Scanner
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary *defaultsDict = [NSMutableDictionary dictionary];    
	[defaultsDict setObject:[NSNumber numberWithBool:YES] forKey:@"ean13upca"];
	[defaultsDict setObject:[NSNumber numberWithBool:YES] forKey:@"ean8"];
	[defaultsDict setObject:[NSNumber numberWithBool:YES] forKey:@"upce"];
	[defaultsDict setObject:[NSNumber numberWithBool:NO] forKey:@"qrcodes"];    
	[defaults registerDefaults:defaultsDict];
    
    NSData *data = [defaults objectForKey:@"bookCollection"];
    NSMutableArray *tempCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (tempCollection) {
        self.bookCollection = [[BookCollection alloc] initWithBooks:tempCollection];
    } else {
        [self populateExData];        
    }
    
    ((BookTabVC*)self.window.rootViewController).bookCollection = self.bookCollection;
    
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
    [self saveState];
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
    [self saveState];
}

- (void)saveState
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setObject:self.bookCollection.collection forKey:@"bookCollection"];
    //[defaults synchronize];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.bookCollection.collection];
    [defaults setObject:data forKey:@"bookCollection"];
    [defaults synchronize];
}

- (void)populateExData
{
    // Add some default books
    NSMutableArray *bookArray = [NSMutableArray arrayWithCapacity:3];
    
    Book *book1 = [[Book alloc] init];
    book1.title = @"Catcher in the Rye";
    book1.author = @"J. D. Salinger";
    book1.read = YES;
    book1.reading = NO;
    book1.lentOut = NO;
    book1.lentTo = @"";
    [bookArray addObject:book1];
    
    Book *book2 = [[Book alloc] init];
    book2.title = @"Slaughterhouse Five";
    book2.author = @"Kurt Vonnegut";
    book1.read = YES;
    book1.reading = YES;
    book1.lentOut = YES;
    book1.lentTo = @"Stacy";
    [bookArray addObject:book2];
    
    Book *book3 = [[Book alloc] init];
    book3.title = @"Cool Book";
    book3.author = @"Cool Guy";
    book1.read = NO;
    book1.reading = NO;
    book1.lentOut = NO;
    book1.lentTo = @"";
    [bookArray addObject:book3];
    
    self.bookCollection = [[BookCollection alloc]initWithBooks:bookArray];
}

@end
