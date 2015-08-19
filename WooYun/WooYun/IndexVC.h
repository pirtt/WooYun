//
//  ViewController.h
//  WooYun
//
//  Created by xikemac02 on 15/8/18.
//  Copyright (c) 2015年 xikemac02. All rights reserved.
//

#import <UIKit/UIKit.h>

enum SessionType
{
    SessionCommit=0,
    SessionAccept=1,
    SessoinPublic=2,
    Sessionidentify=3
    
};
typedef void(^Block_do)(void);

@interface IndexVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView* Tableview;

@property (strong,nonatomic) NSMutableArray* LatestCommit;

@property (strong,nonatomic) NSMutableArray* LatestAccept;

@property (strong,nonatomic) NSMutableArray* LatestPublic;

@property (strong,nonatomic) NSMutableArray* LatestIdentify;


-(void)InitRescoure;

@end

