//
//  ViewController.m
//  Game_ios
//
//  Created by Paul on 14-8-30.
//  Copyright (c) 2014年 Paul. All rights reserved.
//

#import "ViewController.h"
#import "Animals.h"

#import "LingYangViewController.h"



@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,myDelegate,UIAlertViewDelegate>{
    UITextView* _messageTextView;
}

@property (nonatomic, strong) UITableView* myTableView;

@property (nonatomic, strong) Animals* myAnimals;
@property (nonatomic, strong) NSMutableArray*   animailsArray;

@property (nonatomic, strong) NSMutableArray*   dataSoucrd;


@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animailsArray = [NSMutableArray new];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, 300) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.dataSoucrd = [@[@"领养宠物",@"退出"] mutableCopy];
    [self.view addSubview:self.myTableView];
    
    _messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 350, 300, 100)];
    [self.view addSubview:_messageTextView];
    
}

- (void)setAnimals:(NSString *)name{
    Animals* animal = [[Animals alloc] init];
    animal.name = name;
    [self.animailsArray addObject:animal];
    
    NSArray* array2 = @[@"喂食",@"互动",@"退出"];
    self.dataSoucrd = [array2 mutableCopy];
    [_myTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSoucrd.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"rr"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rr"];
    }
    cell.textLabel.text = _dataSoucrd[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_dataSoucrd[indexPath.row] isEqualToString:@"领养宠物"]) {
        LingYangViewController *vc = [[LingYangViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([_dataSoucrd[indexPath.row] isEqualToString:@"喂食"]) {
        BOOL ret = NO;
        for (int i = 0; i < _animailsArray.count; i++) {
            [self eatFood:_animailsArray[i]];
            Animals* an = _animailsArray[i];
            if (!ret) {
                ret = (an.jieValue > 10);
            }
            
        }
        if (ret) {
            self.dataSoucrd = [@[@"领养宠物",@"喂食",@"互动",@"退出"] mutableCopy];
        }else{
            self.dataSoucrd = [@[@"喂食",@"互动",@"退出"] mutableCopy];
        }
        [self showAnimalsMessage];
    }else if ([_dataSoucrd[indexPath.row] isEqualToString:@"互动"]) {
        for (int i = 0; i < _animailsArray.count; i++) {
            [self playGame:_animailsArray[i]];
        }
        [self showAnimalsMessage];
    }else if ([_dataSoucrd[indexPath.row] isEqualToString:@"退出"]) {
        NSLog(@"---------退出----------");
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)setDataSoucrd:(NSMutableArray *)dataSoucrd{
    if (_dataSoucrd == nil) _dataSoucrd = [NSMutableArray new];
    [_dataSoucrd removeAllObjects];
    [_dataSoucrd addObjectsFromArray:dataSoucrd];
    [_myTableView reloadData];
    [self showAnimalsMessage];
}

- (void)setAnimailsArray:(NSMutableArray *)animailsArray{
    if (_animailsArray == nil) _animailsArray = [NSMutableArray new];
    [_animailsArray removeAllObjects];
    [_animailsArray addObjectsFromArray:animailsArray];
}


- (void)eatFood:(Animals*)animal{
    animal.jieValue += 3;
    
    NSLog(@"名字:%@ 饥饿:%d 互动:%d",animal.name,animal.jieValue,animal.hudongValue);
    
}


- (void)playGame:(Animals*)animal{
    animal.hudongValue +=3;
    animal.jieValue -=1;
    NSLog(@"名字:%@ 饥饿:%d 互动:%d",animal.name,animal.jieValue,animal.hudongValue);
    
    
    NSString* tempString = [NSString stringWithFormat:@"%@ 宠物饥饿值小于0,死亡",animal.name];
    if (animal.jieValue <= 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"死亡报告" message:tempString delegate:self cancelButtonTitle:@"重新领养" otherButtonTitles: nil];
        [alert show];
        [self.animailsArray removeObject:animal];
    }
}

- (void)showAnimalsMessage{
    if (self.animailsArray.count == 0) {
        _messageTextView.text = @"暂无宠物,请领养宠物";
    }
    else
    {
        NSMutableString* string = [NSMutableString stringWithCapacity:0];
        for (int i = 0; i < self.animailsArray.count; i++) {
            Animals* animal = self.animailsArray[i];
            [string appendFormat:@"名称:%@  饥饿度:%d  互动值:%d \n",animal.name,animal.jieValue,animal.hudongValue];
        }
        _messageTextView.text = string;
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
    if (self.animailsArray.count == 0) {
        self.dataSoucrd = [@[@"领养宠物",@"退出"] mutableCopy];
    }else{
        self.dataSoucrd = [@[@"喂食",@"互动",@"退出"] mutableCopy];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
