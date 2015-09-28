//
//  UIViewController+Profile.m
//  testLimun
//
//  Created by Nikolay Sozinov on 24.09.15.
//  Copyright © 2015 Nikolay Sozinov. All rights reserved.
//

#import "UIViewControllerProfile.h"

@interface UIViewControllerProfile ()

@end

@implementation UIViewControllerProfile



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.bgColor) {
        self.view.backgroundColor = self.bgColor;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    NSLog(@"Details deallocated");
}


/*

NSString *testXMLString = @"&lt;items&gt;&lt;item id=\"0001\" type=\"donut\"&gt;&lt;name&gt;Cake&lt;/name&gt;&lt;ppu&gt;0.55&lt;/ppu&gt;&lt;batters&gt;&lt;batter id=\"1001\"&gt;Regular&lt;/batter&gt;&lt;batter id=\"1002\"&gt;Chocolate&lt;/batter&gt;&lt;batter id=\"1003\"&gt;Blueberry&lt;/batter&gt;&lt;/batters&gt;&lt;topping id=\"5001\"&gt;None&lt;/topping&gt;&lt;topping id=\"5002\"&gt;Glazed&lt;/topping&gt;&lt;topping id=\"5005\"&gt;Sugar&lt;/topping&gt;&lt;/item&gt;&lt;/items&gt;";

// Parse the XML into a dictionary
NSError *parseError = nil;
NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:testXMLString error:&amp;parseError];

// Print the dictionary
NSLog(@"%@", xmlDictionary);
 
=================================================   разобраться в парсере XML  =======================================================
 
NSURL *url = [NSURL URLWithString:@"http://www.someurl/response.xml"];

ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];

[request startSynchronous];

NSError *error = [request error];

if (!error) {
    
    NSString *response = [request responseString];
    
    // NSLog(@"%@", response);
    
    NSError *parseError = nil;
    
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:response error:&amp;parseError];
    
    // Print the dictionary
    
    NSLog(@"%@", xmlDictionary);
    
}  */

@end
