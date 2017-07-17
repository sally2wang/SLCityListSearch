//
//  SDHotCityCell.m
//  sudaizhijia
//
//  Created by 武传亮 on 2017/4/27.
//  Copyright © 2017年 武传亮. All rights reserved.
//

#import "SLHotCityCell.h"
#import "SLCityModel.h"

#define kMargin 13
#define kButtonWidth 91
#define kGap (kScreenWidth - kButtonWidth * 3 - kMargin - 25) / 2
#define kButtonHeight 27
#define kGapH 9
#define kTopMargin 34

@interface SLHotCityCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;


@end

@implementation SLHotCityCell


- (void)awakeFromNib {
    [super awakeFromNib];

    
}

#define kButtonColor [UIColor blueColor]

- (void)setupView {
    
    NSInteger count = 0;
    CGFloat y = 0.0;
    NSInteger x = 1;
    
    for (int i = 1; i <= self.hotArray.count; i++) {
        
        SLCity *city = self.hotArray[i - 1];
        UIButton *button = [
                            UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor redColor].CGColor;
        button.layer.cornerRadius = 2;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [button setTitle:city.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        if ([city.name isEqualToString:self.locationCity]) {
            
            [button setTitleColor:kButtonColor forState:UIControlStateNormal];
            button.layer.borderColor = kButtonColor.CGColor;
            
        }        
        
        @weakify(self)
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            
//            [self.hotCitySubject sendNext:button.titleLabel.text];
            
             [self.hotCitySubject sendNext:RACTuplePack(@(city.Id), city.name)];
        }];
        
        if (self.hotArray.count > count ) {

            if (((kScreenWidth) - (kMargin + kButtonWidth * (x - 1) + kGap * (x - 1))) <= kButtonWidth) {
                y += kGapH + kButtonHeight;
                x = 1;
            }
            
            button.frame = CGRectMake(kMargin + ((kButtonWidth + kGap) * (x - 1)), kTopMargin + y, kButtonWidth, kButtonHeight);
            count ++;
            x ++;
        }
        
        [self.backView addSubview:button];
        
    }
    
    
}



- (void)setHotArray:(NSArray *)hotArray {
    
    if (!_hotArray) {
        _hotArray = hotArray;
        [self setupView];
        
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end