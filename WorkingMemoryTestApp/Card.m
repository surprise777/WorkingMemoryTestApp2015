//
//  CARD.m
//  WorkingMemoryTestApp
//
//  Created by 晶琦 张 on 15/11/7.
//  Copyright © 2015年 晶琦 张. All rights reserved.
//
#import "Card.h"
@interface Card()
@property(nonatomic,strong)NSMutableArray* history; //history的数组存储的是历史纪录
@end
@implementation Card
- (NSMutableArray *)history//数组初始化
{
    if (!_history) {
        _history=[[NSMutableArray alloc] init];
       //如果数组history为空，则初始化
    }
    return _history;
}
//实现外部接口，可以访问历史纪录
- (NSArray *)matchHistory {
        return self.history;
    }
-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards){
    if([card.contents isEqualToString:self.contents]){
        
        score = 1;

    }
    }
    
    return  score;

}
@end
