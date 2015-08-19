//
//  ViewController.m
//  WooYun
//
//  Created by xikemac02 on 15/8/18.
//  Copyright (c) 2015年 NiuYoohoo. All rights reserved.
//

#import "IndexVC.h"
#import "WebShow.h"
#define NAVHEIGHT self.navigationController.navigationBar.bounds.size.height
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface IndexVC ()<NSURLConnectionDelegate>

@end

@implementation IndexVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self InitRescoure];
    self.Tableview.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    
    
    self.title=@"WooYun";
    NSString *httpUrl = @"http://apis.baidu.com/apistore/wooyun/confirm";
    NSString *httpArg = @"limit=10";
        //确认
    self.LatestCommit =[NSMutableArray arrayWithArray:[self request:httpUrl withHttpArg:httpArg]];
    NSLog(@"%@",self.LatestCommit);
//    NSDictionary *dd=[self.LatestCommit objectAtIndex:0];
//    NSLog(@"%@",dd);
        //公开
    httpUrl=@"http://apis.baidu.com/apistore/wooyun/public";
    self.LatestPublic=[NSMutableArray arrayWithArray:[self request:httpUrl withHttpArg:httpArg]];
        //accept
    httpUrl=@"http://apis.baidu.com/apistore/wooyun/submit";
    self.LatestAccept=[NSMutableArray arrayWithArray:[self request:httpUrl withHttpArg:httpArg]];
        // 认证
    httpUrl=@"http://apis.baidu.com/apistore/wooyun/unclaim";
    self.LatestIdentify=[NSMutableArray arrayWithArray:[self request:httpUrl withHttpArg:httpArg]];
    
    [self.view addSubview:self.Tableview];
}

-(void)InitRescoure
{
    self.LatestAccept=[[NSMutableArray alloc]init];
    self.LatestCommit=[[NSMutableArray alloc]init];
    self.LatestPublic=[[NSMutableArray alloc]init];
    self.LatestIdentify=[[NSMutableArray alloc]init];
    self.Tableview =[[UITableView alloc]init];
    
    self.Tableview.delegate=self;
    self.Tableview.dataSource=self;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identify=@"yoohoo";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identify];
    if(cell==nil)
        {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identify];
        }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font=[UIFont systemFontOfSize:13];
    NSDictionary *dic;
    switch (indexPath.section)
    {
        case SessionAccept:
        dic=[self.LatestAccept objectAtIndex:indexPath.row];
        cell.textLabel.text=[dic objectForKey:@"title"];
            break;
        case SessionCommit:
        dic=[self.LatestCommit objectAtIndex:indexPath.row];
        cell.textLabel.text=[dic objectForKey:@"title"];
        break;
        case SessoinPublic:
        dic=[self.LatestPublic objectAtIndex:indexPath.row];
        cell.textLabel.text=[dic objectForKey:@"title"];
        break;
        case Sessionidentify:
        dic=[self.LatestIdentify objectAtIndex:indexPath.row];
        cell.textLabel.text=[dic objectForKey:@"title"];
        break;
        default:
        cell.textLabel.text=@"";
            break;
    }
    
    
    
    
    
    return cell;
}

-(NSArray*)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg
{
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"6d900da72092b433d1e3b71b3cc3a3fc" forHTTPHeaderField: @"apikey"];
   NSData* data= [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *arry=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
        // NSLog(@"%@",arry);
    return arry;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake((WIDTH-100)/2, 0, 100, 30)];
    view.backgroundColor=[UIColor grayColor];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake((WIDTH-100)/2, 0, 100, 30)];
    [lab setTextColor:[UIColor greenColor]];
    switch (section)
    {
        case SessionAccept:
        lab.text= @"最新提交";
        break;
        case SessionCommit:
        lab.text= @"最新确认";
        break;
        case SessoinPublic:
        lab.text= @"最新公开";
        break;
        case Sessionidentify:
        lab.text= @"待认领";
        break;
        default:
       lab.text=@"";
        break;
    }
    [view addSubview:lab];
    
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebShow *newWeb=[[WebShow alloc]init];
    NSDictionary *dic;
    switch (indexPath.section)
    {
        case SessionAccept:
        dic =[self.LatestAccept objectAtIndex:indexPath.row];
        newWeb.urlstr =[dic objectForKey:@"link"];
        newWeb.title=[dic objectForKey:@"author"];
        [self.navigationController pushViewController:newWeb animated:YES];
            break;
        case SessionCommit:
        dic =[self.LatestCommit objectAtIndex:indexPath.row];
        newWeb.urlstr =[dic objectForKey:@"link"];
        newWeb.title=[dic objectForKey:@"author"];
        [self.navigationController pushViewController:newWeb animated:YES];
            break;
        case SessoinPublic:
        dic =[self.LatestPublic objectAtIndex:indexPath.row];
        newWeb.urlstr =[dic objectForKey:@"link"];
        newWeb.title=[dic objectForKey:@"author"];
        [self.navigationController pushViewController:newWeb animated:YES];
            break;
        case Sessionidentify:
        dic =[self.LatestIdentify objectAtIndex:indexPath.row];
        newWeb.urlstr =[dic objectForKey:@"link"];
        newWeb.title=[dic objectForKey:@"author"];
        [self.navigationController pushViewController:newWeb animated:YES];
            break;
        default:
            break;
    }
}



@end
