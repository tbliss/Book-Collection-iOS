//
//  ScannerVC.m
//  BookCollection
//
//  Created by Trevor Bliss on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScannerVC.h"
#import "AddBookVC.h"

@interface ScannerVC ()

@end

@implementation ScannerVC
@synthesize addBookVC = _addBookVC;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startScan];
}

- (void) startScan
{
    if([SKScannerViewController canRecognizeBarcodes]) {
        SKScannerViewController *scannerVC = [[SKScannerViewController alloc] init]; //Insantiate a new SKScannerViewController
        
        scannerVC.delegate = self;
        scannerVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTapped)];
        scannerVC.title = @"Scan a Barcode";
        
        scannerVC.shouldLookForEAN13AndUPCACodes = [[NSUserDefaults standardUserDefaults] boolForKey:@"ean13upca"];
        scannerVC.shouldLookForEAN8Codes = [[NSUserDefaults standardUserDefaults] boolForKey:@"ean8"];
        scannerVC.shouldLookForQRCodes = [[NSUserDefaults standardUserDefaults] boolForKey:@"qrcodes"];
        scannerVC.shouldLookForUPCECodes = [[NSUserDefaults standardUserDefaults] boolForKey:@"upce"];
        
        UINavigationController *_nc = [[UINavigationController alloc] initWithRootViewController:scannerVC]; //Put our SKScannerViewController into a UINavigationController. (So it looks nice).
        
        [self presentModalViewController:_nc animated:NO]; //Slide it up onto the screen.
        //[self presentViewController:_nc animated:NO completion:NULL];
    } else {
        //NSLog(@"NOT able to recognize barcodes");
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This device doesn't support barcode recognition." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
        
        //[self dismissModalViewControllerAnimated:NO];
        //[self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) cancelTapped {
	[self dismissModalViewControllerAnimated:NO];
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:NO completion:NULL];
}

#pragma mark SKScannerViewControllerDelegate Methods

- (void) scannerViewController:(SKScannerViewController *)scanner didRecognizeCode:(SKCode *)code {
	//NSLog(@"didRecognizeCode = %@", code.rawContent);
    
	//AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
	[self dismissModalViewControllerAnimated:NO]; //We're done scanning barcodes so we should dismiss our modal view controller.
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.addBookVC sendISBN:code.rawContent];
}

- (void) scannerViewController:(SKScannerViewController *)scanner didStopLookingForCodesWithError:(NSError *)error {
	[self dismissModalViewControllerAnimated:YES];
    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                    message:[[error userInfo] 
                                               objectForKey:@"Reason"] 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    
	[alert show];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
