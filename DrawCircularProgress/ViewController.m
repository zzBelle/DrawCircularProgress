//
//  ViewController.m
//  DrawCircularProgress
//
//  Created by 十月 on 2017/8/29.
//  Copyright © 2017年 Belle. All rights reserved.
//

#import "ViewController.h"
#import "DrawCircularView.h"

#define kColorWithRGB(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width//获取屏幕高度

#define kCommonGreenColor kColorWithRGB(111.0, 191.0, 106.0, 1.0)

@interface ViewController (){

    NSTimer *_timer;
    NSString *_state;

    DrawCircularView *largeCircle;
    DrawCircularView *middleCircle;
    DrawCircularView *smallCircle;
    
    float bigCircleProgress;
    float middleCircleProgress;
    float smallCircleProgress;
    float endTime;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建视图
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems: @[@"今日",@"本周"]];
    segment.frame = CGRectMake((SCREEN_WIDTH - 288)/2, 30, 288, 44);
    segment.selectedSegmentIndex = 0;
    segment.layer.borderColor = kCommonGreenColor.CGColor;
    segment.layer.borderWidth = 1;
    segment.layer.cornerRadius = 22;
    segment.layer.masksToBounds = YES;
    [segment setTintColor:kCommonGreenColor];
    [segment addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];

    [self drawCircle];
}

- (void)changeTime:(UISegmentedControl *)segment{
    
    _state = [NSString stringWithFormat:@"%ld",segment.selectedSegmentIndex+1];
    [self editFrame];

    
}

- (void)drawCircle {
    // 外层圆
    largeCircle = [[DrawCircularView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 194) / 2, 200, 194, 194)];
    largeCircle.progressTintColor = kColorWithRGB(255, 133, 73, 1.0);
    largeCircle.backgroundColor = kColorWithRGB(255, 133, 73, 0.1);
    largeCircle.layer.cornerRadius = largeCircle.frame.size.width/2;
    largeCircle.layer.masksToBounds = YES;
    [self.view addSubview:largeCircle];
    
    // 中间的圆
    middleCircle = [[DrawCircularView alloc] initWithFrame:CGRectMake(0, 0, 148, 148)];
    middleCircle.center = largeCircle.center;
    middleCircle.progressTintColor = kColorWithRGB(249, 202, 1, 1.0);
    middleCircle.backgroundColor = kColorWithRGB(249, 202, 1, 0.1);
    middleCircle.layer.cornerRadius = middleCircle.frame.size.width/2;
    middleCircle.layer.masksToBounds = YES;
    [self.view addSubview:middleCircle];
    
    // 小圆
    smallCircle = [[DrawCircularView alloc] initWithFrame:CGRectMake(0, 0, 102, 102)];
    smallCircle.center = largeCircle.center;
    smallCircle.progressTintColor = kColorWithRGB(82, 213, 206, 1.0);
    smallCircle.backgroundColor = kColorWithRGB(82, 213, 206, 0.1);
    smallCircle.layer.cornerRadius = smallCircle.frame.size.width/2;
    smallCircle.layer.masksToBounds = YES;
    [self.view addSubview:smallCircle];
    
    
    // 定时器 加载进度
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(progressChange) userInfo:nil repeats:YES];

}

- (void)progressChange {
    largeCircle.progress += 0.01;
    
    middleCircle.progress += 0.01;
    
    smallCircle.progress += 0.01;
    
    
    endTime += 0.01;
    
    if (largeCircle.progress > bigCircleProgress){
        largeCircle.progress = bigCircleProgress;
    }
    
    if (middleCircle.progress >middleCircleProgress){
        
        middleCircle.progress = middleCircleProgress;
    }
    
    if (smallCircle.progress > smallCircleProgress){
        smallCircle.progress = smallCircleProgress;
    }
    
    // 关闭定时器
    if (endTime > 2) {
        
        [_timer setFireDate:[NSDate distantFuture]];
        
    }
}

- (void)editFrame {
    
    float allCount = 20;
    endTime = 0;
    if (allCount != 0) {
        
        bigCircleProgress = 2 / allCount; 
        middleCircleProgress = 7 / allCount;
        smallCircleProgress = 10 / allCount;
        
        if (bigCircleProgress == 1) {
            bigCircleProgress = 0.75;
        }
        if (middleCircleProgress == 1) {
            middleCircleProgress = 0.75;
        }
        if (smallCircleProgress == 1) {
            smallCircleProgress = 0.75;
        }
        [_timer setFireDate:[NSDate distantPast]];  //开启

    
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
