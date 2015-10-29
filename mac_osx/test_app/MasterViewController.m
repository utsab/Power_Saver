//
//  MasterViewController.m
//  test_app
//
//  Created by Utsab Saha on 10/24/15.
//  Copyright (c) 2015 My Company. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)checkBoxChecked:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://localhost:3000/api/users"]];
}


- (IBAction)sliderValueChanged:(id)sender {
    NSSlider *s = (NSSlider *)sender;
    NSLog(@"slider value = %f", s.doubleValue);
    
    if (s.doubleValue == 0) {
        NSLog(@"set timer!!!!!!");
        [NSTimer scheduledTimerWithTimeInterval:3.0
                                         target:self
                                       selector:@selector(putComputerToSleep)
                                       userInfo:nil
                                        repeats:NO];
    }
    
    
    int savedVal = 287 - (s.doubleValue/100) * 287;
    
    NSString *savedText = [NSString stringWithFormat:@"%d kWH saved per year", savedVal];
    
    int carbonSaved = savedVal * 1.2;
    
    NSString *carbonSavedText = [NSString stringWithFormat:@"%d pounds of carbon", carbonSaved];
    
    
    
    [self.savedKW setStringValue:savedText];
    [self.carbonSaved setStringValue:carbonSavedText];

    
    //[[NSApplication sharedApplication] mainWindow].backgroundColor = [NSColor colorWithOrange:0.5 green:0.5 blue:0.5 alpha:1.0];
    
    
}


- (void) putComputerToSleep {

    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/pmset";
    task.arguments  = @[@"displaysleepnow"];
    
    [task launch];
    
}



- (void) chargeUserForFailure {
    NSString *post = [NSString stringWithFormat:@"action=reward"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://upear.ly/actions.php"]]; //TODO: don't hardcode user id to 4
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
    
}


// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    NSLog(@"In didReceiveData");
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"In didFailWithError");
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"In didFinishLoading");
}





@end
