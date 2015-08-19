//
//  WebShow.h
//  WooYun
//
//  Created by xikemac02 on 15/8/18.
//  Copyright (c) 2015年 xikemac02. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NAVHEIGHT self.navigationController.navigationBar.bounds.size.height
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface WebShow : UIViewController
@property (strong,nonatomic) NSString* urlstr;

@end
