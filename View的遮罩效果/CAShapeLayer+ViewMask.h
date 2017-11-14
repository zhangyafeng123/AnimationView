//
//  CAShapeLayer+ViewMask.h
//  View的遮罩效果
//
//  Created by linjianguo on 2017/11/14.
//  Copyright © 2017年 com.justsee. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CAShapeLayer (ViewMask)

+(instancetype)createMaskLayerWithView:(UIView *)view;


@end
