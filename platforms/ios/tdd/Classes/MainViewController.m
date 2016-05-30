/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  Hello World
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"
#import "GlobalVariables.h"

@implementation MainViewController



- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
        
        
        [[GlobalVariables singleTonClass] setG_Host:[NSString stringWithFormat:@"%@",@"218.38.16.214:7000"]];
        //[[GlobalVariables singleTonClass] setG_Host:[NSString stringWithFormat:@"%@",@"122.99.170.230"]];

        
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        CGRect viewBounds = [self.webView bounds];
        
        viewBounds.origin.y = 20;
        
        viewBounds.size.height = viewBounds.size.height-20;
        
        self.webView.frame=viewBounds;
        
    }
    
    // View defaults to full size.  If you want to customize the view's size, or its subviews (e.g. webView),
    // you can do so here.
    /**
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        CGRect viewBounds = [self.webView bounds];
        viewBounds.origin.y = 20;
        viewBounds.size.height = viewBounds.size.height-20;
        self.webView.frame=viewBounds;
    }
    
    [super viewWillAppear:animated];
     **/
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    NSString *indexFilePath = [[NSBundle mainBundle] pathForResource:@"newsfeed" ofType:@"html" inDirectory:@"www/news"];
    NSURL *indexUrl = [NSURL fileURLWithPath:indexFilePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:indexUrl];
    
    [self.webView loadRequest:request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

/* Comment out the block below to over-ride */

/*
- (UIWebView*) newCordovaViewWithFrame:(CGRect)bounds
{
    return[super newCordovaViewWithFrame:bounds];
}
*/

#pragma mark UIWebDelegate implementation

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    // Black base color for background matches the native apps
    theWebView.backgroundColor = [UIColor blackColor];

    return [super webViewDidFinishLoad:theWebView];
}

/* Comment out the block below to over-ride */

/*

- (void) webViewDidStartLoad:(UIWebView*)theWebView
{
    return [super webViewDidStartLoad:theWebView];
}

- (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
    return [super webView:theWebView didFailLoadWithError:error];
}

- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
}
*/
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *strUrl = [[request URL] absoluteString];
    //strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([strUrl hasPrefix:@"toapp://"]) {
        
        // ex) location.href = "toAPP://fnCalendar?formName=" + form + "&isValue=" + isValue;
        // strRequest : "fnCalendar?formName=" + form + "&isValue=" + isValue;
        // arrRequest : "fnCalendar?formName=" + form + "&isValue=" + isValue; 를 '?'로 자른거
        // strCmd : "fnCalendar"  arrRequest의 ? 앞에꺼
        
        NSString *strRequest = [[[strUrl componentsSeparatedByString:@"://"] objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *arrRequest = [strRequest componentsSeparatedByString:@"?"];
        
        //NSString *strRequest2 = [[strUrl componentsSeparatedByString:@"://"] objectAtIndex:1];
        //NSArray *arrRequest2 = [strRequest2 componentsSeparatedByString:@"?"];
        
        NSString *strCmd = [arrRequest objectAtIndex:0];
        
        NSLog(@"App에 받아오는 함수 strCmd : %@", strCmd);
        
        if (YES == [@"fnGCMRegister" isEqualToString:strCmd]) {
            
            
            NSArray *arrQuerString = [[arrRequest objectAtIndex:1] componentsSeparatedByString:@"&"];
            
            NSArray *arrMemberId = [[arrQuerString objectAtIndex:0]componentsSeparatedByString:@"="];
            NSString *strMemberId = [arrMemberId objectAtIndex:1];
            
            NSString *strDiviceId = [[GlobalVariables singleTonClass] G_DeviceId];
            
            //NSString *host = @"218.38.16.214:7000";
            NSString *host = [[GlobalVariables singleTonClass] G_Host];
            NSString *urlString = [@"/talk/insertDeviceToken.do?" stringByAppendingFormat:@"memberId=%@", strMemberId];
            urlString = [urlString stringByAppendingFormat:@"&deviceToken=%@", strDiviceId];
            urlString = [urlString stringByAppendingFormat:@"&osType=%@", @"I"];
            
            
            NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSLog(@"Register URL: %@", url);
            NSLog(@"Return Data: %@", returnData);
            
            NSString *strReturnScript = [NSString stringWithFormat:@"%@", @"location.href = '../news/newsfeed.html?tnGubun=0'"];
            
            
            [webView stringByEvaluatingJavaScriptFromString:strReturnScript];
            
        }
        return NO;
    }
    
    return YES;
}


@end

@implementation MainCommandDelegate

/* To override the methods, uncomment the line in the init function(s)
   in MainViewController.m
 */

#pragma mark CDVCommandDelegate implementation

- (id)getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

- (NSString*)pathForResource:(NSString*)resourcepath
{
    return [super pathForResource:resourcepath];
}

@end

@implementation MainCommandQueue

/* To override, uncomment the line in the init function(s)
   in MainViewController.m
 */
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

@end
