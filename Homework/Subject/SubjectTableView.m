//
//  SubjectTableView.m
//  Homework
//
//  Created by 牛晨雨 on 2020/8/20.
//  Copyright © 2020 牛晨雨. All rights reserved.
//

#import "SubjectTableView.h"
#import "SubjectTVCell.h"
#import "MissionViewController.h"

@implementation SubjectTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"SubjectTVCell" bundle:nil] forCellReuseIdentifier:@"Subject"];
    }
    return self;
}

#pragma mark - tableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [AppManager defualtManager].allSubjectInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SubjectTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Subject" forIndexPath:indexPath];
    NSDictionary *dict = [AppManager defualtManager].allSubjectInfo[indexPath.row];
    cell.iconImgView.image = [UIImage imageWithData:dict[@"icon"]];
    cell.subjectNameL.text = dict[@"name"];
    return cell;
}

// TableView Header, Footer
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

// UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath:%@",indexPath);
    NSDictionary *dict = [AppManager defualtManager].allSubjectInfo[indexPath.row];
    MissionViewController *missionVC = [[MissionViewController alloc]init];
    missionVC.subjectName = dict[@"name"];
    [self.mainVC.navigationController pushViewController:missionVC animated:YES];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end