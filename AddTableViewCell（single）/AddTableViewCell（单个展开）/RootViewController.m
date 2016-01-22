//
//  RootViewController.m
//  AddTableViewCell（单个展开）
//
//  Created by macbook on 16/1/5.
//  Copyright © 2016年 DLD. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    
    //展开的index
    NSInteger _indexOpen;
    
    NSInteger _indexAdd;
}
@end

@implementation RootViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    _indexAdd = -1;
    _indexOpen = -1;
    
    _dataArray = [NSMutableArray arrayWithObjects:@"a",@"a",@"a",@"a",@"a", nil];
    [_tableView reloadData];
}

#pragma mark -- UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row==_indexAdd?100:50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indexPath.row==_indexAdd?@"addCell":@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexPath.row==_indexAdd?@"addCell":@"add"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = _indexAdd==indexPath.row?[UIColor yellowColor]:[UIColor clearColor];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_indexOpen == -1&&_indexAdd == -1) {
        _indexOpen = indexPath.row;
        _indexAdd = indexPath.row+1;
        
        [_dataArray insertObject:@"我是展开项目" atIndex:_indexAdd];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[self newIndexPath:indexPath]] withRowAnimation:UITableViewRowAnimationTop];
        return;
    }
    if (_indexOpen == indexPath.row) {
        _indexOpen = -1;
        _indexAdd = -1;
        [_dataArray removeObjectAtIndex:indexPath.row+1];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[self newIndexPath:indexPath]] withRowAnimation:UITableViewRowAnimationTop];
        return;
    }
    if (_indexOpen != indexPath.row && _indexOpen!= -1) {
        [_dataArray removeObjectAtIndex:_indexAdd];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_indexAdd inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationTop];
        NSLog(@"%@",_dataArray);
        if (indexPath.row>_indexAdd) {
            _indexOpen = indexPath.row-1;
            _indexAdd = indexPath.row;
            [_dataArray insertObject:@"我是展开项目" atIndex:_indexAdd];
            NSLog(@"%@",_dataArray);

            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        }
        else{
            _indexOpen = indexPath.row;
            _indexAdd = indexPath.row+1;
            [_dataArray insertObject:@"我是展开项目" atIndex:_indexAdd];
            NSLog(@"%@",_dataArray);
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_indexAdd inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationTop];
        }
        
        NSLog(@"%ld,%ld",_indexOpen,_indexAdd);
    }
}

#pragma mark -- 自由方法

- (NSIndexPath *)newIndexPath:(NSIndexPath *)indexPath{
    return [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
}

@end






