//
//  WebShow.m
//  WooYun
//
//  Created by xikemac02 on 15/8/18.
//  Copyright (c) 2015年 xikemac02. All rights reserved.
//

#import "WebShow.h"

@implementation WebShow


-(void)viewDidLoad
{
    
    
    UIBarButtonItem *leftbutton=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(jump)];
    self.navigationItem.leftBarButtonItem=leftbutton;
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    if(_urlstr==nil)
        {
        _urlstr=[NSString stringWithFormat:@""];
        }
    NSURL *url=[NSURL URLWithString:_urlstr];
    
    NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
    [webview loadRequest:request];
        //webview.scrollView.scrollEnabled=NO;
    [self.view addSubview:webview];
}

-(void)jump
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
