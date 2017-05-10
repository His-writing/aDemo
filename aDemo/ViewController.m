//
//  ViewController.m
//  aDemo
//
//  Created by shuzhenguo on 2017/3/8.
//  Copyright © 2017年 shuzhenguo. All rights reserved.
//

#import "ViewController.h"
#import "AlsoTableViewCell.h"
#import "AleTableViewCell.h"
static NSString * const kImageCell = @"AlsoTableViewCell";

static NSString * const kImageTCell = @"AleTableViewCell";


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    BOOL isOpen;
    NSIndexPath *selectIndex;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic) NSInteger selectSection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    isOpen=YES;
//    _dataArr=[[NSMutableArray alloc]initWithObjects:@"a",@"b",@"c",@"d",@"b",@"c",@"d", nil];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AlsoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kImageCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kImageTCell];

    

}
#pragma  mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectIndex.row == indexPath.row && selectIndex!=nil)
    {
        if (isOpen) {
            return 120;
        }
        return 60;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    static NSString *cellID=@"CELLID";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
    
    
    
    if (selectIndex.row == indexPath.row && selectIndex!=nil ) {
        if (isOpen) {
            
            
            AlsoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kImageCell];
            //可自定义当前cell样式
//            cell.textLabel.text=@"120的高度";
//            cell.backgroundColor=[UIColor whiteColor];
            
            return cell;

        }else {
            AleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kImageTCell];

//            //恢复原状（定义原cell并填充）
//            cell.textLabel.text=@"点击过后的80的高度";
//            cell.backgroundColor=[UIColor whiteColor];
            
            return cell;

        }
    }else {
        
        AleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kImageTCell];

//        cell.textLabel.text=@"没点击的是50高度";
//        cell.backgroundColor=[UIColor whiteColor];
        
        return cell;

        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //更改选中cell的状态 用以 刷新页面是进行折叠和展开
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    if (selectIndex!=nil &&indexPath.row ==selectIndex.row) {
        isOpen=!isOpen;
    }else if (selectIndex!=nil && indexPath.row!=selectIndex.row) {
        indexPaths = [NSArray arrayWithObjects:indexPath,selectIndex, nil];
        isOpen=YES;
    }
    selectIndex=indexPath;
    //刷新
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
