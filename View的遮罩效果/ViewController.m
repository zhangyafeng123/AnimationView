//
//  ViewController.m
//  View的遮罩效果
//
//  Created by linjianguo on 2017/11/14.
//  Copyright © 2017年 com.justsee. All rights reserved.
//

#import "ViewController.h"
#import "CAShapeLayer+ViewMask.h"


#define TOTAL_NUM 10

@interface ViewController ()
@property (nonatomic, strong)UIView *dynamicView;
@property (nonatomic, strong)CAShapeLayer *indicateLayer;
@property (nonatomic, strong)UIView *demoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 100, 100)];
    imageV.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:imageV];
    CAShapeLayer *layer = [CAShapeLayer createMaskLayerWithView:imageV];
    imageV.layer.mask = layer;
    
    //音量加减
    _dynamicView = [[UIView alloc] initWithFrame:CGRectMake(20, 250, 50, 100)];
    _dynamicView.backgroundColor = [UIColor lightGrayColor];
    _dynamicView.layer.borderWidth = 1.0;
    _dynamicView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _dynamicView.layer.cornerRadius = 25;
    _dynamicView.layer.masksToBounds = YES;
    _dynamicView.clipsToBounds = YES;
    
    [self.view addSubview:_dynamicView];
    
    [self refreshUIWithVoicePower:5];
    
    //圆形进度条的实现代码
    
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(20, 400, 100, 100)];
    [self.view addSubview:_demoView];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _demoView.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_demoView.bounds];
    
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    [_demoView.layer addSublayer:shapeLayer];
   
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 3.0f;
    //设置动画的速度变化
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //所改变属性的起始值
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    //所改变属性的结束时的值
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    //设置结束的时候不隐藏.
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    //将 CABasicAniamtion 对象进行了 copy 操作的.
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}
-(void)refreshUIWithVoicePower : (NSInteger)voicePower{
    CGFloat height = (voicePower)*(CGRectGetHeight(_dynamicView.frame)/TOTAL_NUM);
    
    [_indicateLayer removeFromSuperlayer];
    _indicateLayer = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetHeight(_dynamicView.frame)-height, CGRectGetWidth(_dynamicView.frame), height) cornerRadius:0];
    _indicateLayer = [CAShapeLayer layer];
    _indicateLayer.path = path.CGPath;
    _indicateLayer.fillColor = [UIColor whiteColor].CGColor;
    [_dynamicView.layer addSublayer:_indicateLayer];
}


@end
