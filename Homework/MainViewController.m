//
//  MainViewController.m
//  Homework
//
//  Created by 牛晨雨 on 2020/8/19.
//  Copyright © 2020 牛晨雨. All rights reserved.
//

#import "MainViewController.h"
#import "SubjectTableView.h"
#import "NewSubjectViewController.h"
#import "SettingViewController.h"

@interface MainViewController () {
    SubjectTableView *subjectTV;
}
@property (nonatomic, strong) UIImageView *bgImgView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Duelendar";
    self.view.backgroundColor = [UIColor clearColor];
    [self setupNavigationBar];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([[user objectForKey:@"ChangeBackgrounImg"] boolValue] == YES) {
        [user setBool:NO forKey:@"ChangeBackgrounImg"];
        NSString *bgImgName = [user objectForKey:@"BackgroundImg"];
        _bgImgView.image = [UIImage imageNamed:bgImgName];
    }
    if ([AppManager defualtManager].addSubjectFlag) {
        [AppManager defualtManager].addSubjectFlag = NO;
        [subjectTV reloadData];
    }
}

- (void)setupNavigationBar {
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [moreBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(settingBarBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *moreBarBtn = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItem = moreBarBtn;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17.0 weight:UIFontWeightBold]}];
}

- (void)settingBarBtnAction:(UIBarButtonItem *)sender {
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)setupView {
//    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize size = self.view.frame.size;
    // header view
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height * .3)];
    headerView.backgroundColor = RGB(46, 37, 28, 1);
    [self.view addSubview:headerView];
    
    UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    iconView.frame = CGRectMake(30, WD_TopHeight + 30, 80, 80);
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = 40;
    [self.view addSubview:iconView];
    
    UILabel *userNameL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) + 20, 0, size.width - CGRectGetMaxX(iconView.frame) - 20, iconView.frame.size.height)];
    userNameL.text = @"Tilly Liu";
    [self.view addSubview:userNameL];
    userNameL.center = CGPointMake(userNameL.center.x, iconView.center.y);
    
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame) + 40, size.width*.8, 100)];
    middleView.backgroundColor = RGB(238, 228, 210, 1);
    middleView.layer.masksToBounds = YES;
    middleView.layer.cornerRadius = 30;
    [self.view addSubview:middleView];
    middleView.center = CGPointMake(self.view.center.x, middleView.center.y);
    
//    UILabel *titleL = [UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(iconView.frame), CGRectGetMaxY(middleView.frame) + 20, <#CGFloat width#>, <#CGFloat height#>)
    
    NSString *bgImgName = [[NSUserDefaults standardUserDefaults] objectForKey:@"BackgroundImg"];
    if (!bgImgName) {
        bgImgName = @"city01";
    }
    _bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:bgImgName]];
    _bgImgView.frame = self.view.frame;
    [self.view addSubview:_bgImgView];
        
    CGFloat height = WD_TopHeight + 100;
    // table view
    subjectTV = [[SubjectTableView alloc]initWithFrame:CGRectMake(0, height, CGRectGetWidth(self.view.frame), self.view.frame.size.height - height - 64) style:(UITableViewStyleGrouped)];
    subjectTV.mainVC = self;
    subjectTV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:subjectTV];
    
    UIButton *addSubjectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(subjectTV.frame), CGRectGetWidth(self.view.frame), self.view.frame.size.height - CGRectGetMaxY(subjectTV.frame))];
    addSubjectBtn.backgroundColor = [UIColor whiteColor];
    [addSubjectBtn setTitle:@"添加学科" forState:(UIControlStateNormal)];
    [addSubjectBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [addSubjectBtn addTarget:self action:@selector(addSubjectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addSubjectBtn];
}

- (void)addSubjectAction:(UIButton *)sender {
    NewSubjectViewController *newSubjectVC = [[NewSubjectViewController alloc]init];
    [self.navigationController pushViewController:newSubjectVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end