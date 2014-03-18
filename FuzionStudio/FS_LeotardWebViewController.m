//
//  FS_LeotardWebViewController.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/3/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import "FS_LeotardWebViewController.h"

@interface FS_LeotardWebViewController ()

@end

@implementation FS_LeotardWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"%@", _requestedURL]];
	
	_urlRequest = [NSURLRequest requestWithURL:urlString];
    [_webView loadRequest:_urlRequest];
    _webView.backgroundColor = [UIColor clearColor];
    [_spinner startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_spinner stopAnimating];
}

@end
