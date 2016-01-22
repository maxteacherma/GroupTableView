//
//  RootViewController.m
//  AddTableViewCell
//
//  Created by macbook on 16/1/4.
//  Copyright © 2016年 DLD. All rights reserved.
//

#import "RootViewController.h"
#import "Cell.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    NSMutableArray * _changeArray;
}
@end

@implementation RootViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray arrayWithArray:@[@"猪",@"猪",@"猪",@"猪",@"猪",@"猪"]];
    [_tableView reloadData];
    
    _changeArray = [NSMutableArray array];
}

#pragma mark -- UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Cell * cell = [tableView dequeueReusableCellWithIdentifier:[self isAddCellWithIndexPath:indexPath]];
    if (cell == nil) {
        cell = [[Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self isAddCellWithIndexPath:indexPath]];
        if ([_changeArray containsObject:@(indexPath.row)]) {
            cell.isAddCell = YES;
        }
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    //
    if (cell.isAddCell) {
        cell.backgroundColor = [UIColor grayColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_changeArray containsObject:@(indexPath.row)]) {
        return 155;
    }
    else
        return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    Cell * selCell = (Cell*)cell;
    if (!selCell.isOpen&&!selCell.isAddCell) {
        selCell.isOpen = YES;
        [_dataArray insertObject:@"aaaa" atIndex:indexPath.row+1];
        [self changeArrayChangeObjectWith:indexPath andState:YES];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[self addIndexPath:indexPath]] withRowAnimation:UITableViewRowAnimationTop];
    }
    else if(selCell.isOpen&&!selCell.isAddCell){
        selCell.isOpen = NO;
        [self changeArrayChangeObjectWith:indexPath andState:NO];
        [_dataArray removeObjectAtIndex:indexPath.row+1];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[self addIndexPath:indexPath]] withRowAnimation:UITableViewRowAnimationTop];
        
    }
}


#pragma mark --  私有方法

//判断cell的identifier
- (NSString *)isAddCellWithIndexPath:(NSIndexPath *)indexPath{
    return [_changeArray containsObject:@(indexPath.row)]?@"cell":@"addCell";
}

- (NSIndexPath *)addIndexPath:(NSIndexPath *)indexPath{
    return [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
}

//添加新的展开条
- (void)changeArrayChangeObjectWith:(NSIndexPath *)indexPath andState:(BOOL)isAdd{
    NSIndexPath * indexPathNew = [self addIndexPath:indexPath];
    if (_changeArray.count!=0) {
        for (int i = 0; i<_changeArray.count; i++) {
            if ([_changeArray[i] integerValue]>indexPathNew.row) {
                [_changeArray replaceObjectAtIndex:i withObject:@(isAdd?[_changeArray[i] integerValue]+1:[_changeArray[i] integerValue]-1)];
            }
        }
    }
    NSNumber * intId = @(indexPathNew.row);
    NSLog(@"%@",intId);
    if (isAdd) {
        [_changeArray addObject:intId];
    }
    else{
        
        [_changeArray removeObject:intId];
    }
    NSLog(@"%@",_changeArray);
}



@end
