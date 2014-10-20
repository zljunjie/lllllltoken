//
//  LingYangViewController.h
//  Game_ios
//
//  Created by Paul on 14-8-30.
//  Copyright (c) 2014年 Paul. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol myDelegate <NSObject>

- (void)setAnimals:(NSString*)name;

@end

@interface LingYangViewController : UIViewController

@property (nonatomic, weak) id<myDelegate> delegate;

@end
