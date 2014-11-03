//
//  LingYangViewController.m
//  Game_ios
//
//  Created by Paul on 14-8-30.
//  Copyright (c) 2014年 Paul. All rights reserved.
//




#import "LingYangViewController.h"




@interface LingYangViewController (){
    UITextField* text ;
    UIView* maskView;
}

@end

@implementation LingYangViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"==========");
        NSMutableArray *array = [NSMutableArray new];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view.
    NSArray* fff = @[@"ff"];
    NSArray* array = @[@"小猫",@"小狗",@"小狼",@"返回"];
    
    
    for (int i = 0; i < 4; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(100, 100 + (i * 50), 100, 30);
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [self.view addSubview:btn];
    }
    // NSArray* array = @[@"小猫",@"小狗",@"小狼",@"返回"]; NSArray* array = @[@"小猫",@"小狗",@"小狼",@"返回"]; NSArray* array = @[@"小猫",@"小狗",@"小狼",@"返回"]; NSArray* array = @[@"小猫",@"小狗",@"小狼",@"返回"]; NSArray* array = @[@"小猫",@"小狗",@"小狼",@"返回"]; NSArray* array = @[@"小猫",@"小狗",@"小狼",@"返回"];
    
    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    maskView.backgroundColor = [UIColor whiteColor];
    maskView.hidden = YES;
    
    text = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, 200, 40)];
    text.placeholder = @"请输入宠物的名字";
    text.backgroundColor = [UIColor cyanColor];
    [maskView addSubview:text];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 100, 30);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"领养" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(lingyang:) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:button];
    [self.view addSubview:maskView];
    
}

- (void)lingyang:(UIButton*)btn{
    [self.delegate setAnimals:text.text];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)clicked:(UIButton*)btn{
    if (btn.tag == 4) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        maskView.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
