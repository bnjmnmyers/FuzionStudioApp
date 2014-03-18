//
//  FS_LeotardWebViewController.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/3/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DressCode.h"
#import "FS_DressCodeTableViewController.h"

@interface FS_LeotardWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) DressCode *currentDressCode;

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *requestedURL;
@property (nonatomic, strong) NSURLRequest *urlRequest;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
