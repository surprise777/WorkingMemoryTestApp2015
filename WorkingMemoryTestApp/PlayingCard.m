//
//  PlayingCard.m
//  WorkingMemoryTestApp
//
//  Created by 晶琦 张 on 15/11/8.
//  Copyright © 2015年 晶琦 张. All rights reserved.
//


#import "PlayingCard.h"
@interface PlayingCard()
@property(nonatomic,strong)NSMutableArray* history;
@end
@implementation PlayingCard
- (int)match:(NSArray *)otherCards{
    int score = 0;
    int matchCount = 0;
    NSMutableArray *history = [[NSMutableArray alloc] init];
    //创建可变数组matchArray，它包含数组otherCards是所有要参与匹配的牌
    NSMutableArray *matchArray = [[NSMutableArray alloc]initWithArray:otherCards];
    [matchArray addObject:self];
    //遍历所有的牌
    while ([matchArray count])
    {
        Card *matchCard = matchArray.lastObject;
        //确保matchArray里的对象是PlayingCard所允许的扑克对象，即判断是否可以参与匹配
        if ([matchCard isKindOfClass:[PlayingCard class]])
        {
            //将matchArray里的对象强制转化为PlayingCard里的对象card
            PlayingCard *card = (PlayingCard *)matchCard;
            //把刚才转化的对象从matchArray移除
            [matchArray removeObject:matchCard];
            //遍历matchArray里所有剩余的牌
            for (Card *otherMatchCard in matchArray)
            {
                if ([otherMatchCard isKindOfClass:[PlayingCard class]])
                {
                    PlayingCard *otherCard = (PlayingCard *)otherMatchCard;
                    //比较两张牌
                    if ([card.suit isEqualToString:otherCard.suit])
                    {
                        score += 1;
                        matchCount++;
                        [history addObject:[[NSString alloc]
                                            initWithFormat:@" %@ 和 %@ 花色匹配上了，得到1*4分",card.contents,otherCard.contents]];
                    }
                    else if (card.rank == otherCard.rank)
                    {
                        score+=4;
                        matchCount++;
                        [history addObject:[[NSString alloc]
                                            initWithFormat:@" %@ 和 %@ 大小匹配上了，得到4*4分",card.contents,otherCard.contents]];
                    }
                }
            }
        }
    }
    if (!score) //如果没有匹配上的牌
    {
        NSMutableString *cardText = [[NSMutableString alloc]init];
        NSMutableArray *cards = [[NSMutableArray alloc] initWithArray:otherCards];
        [cards addObject:self];
        while([cards count])
        {
            Card *matchCard = cards.lastObject;
            [cards removeObject:matchCard];
            if ([matchCard isKindOfClass:[PlayingCard class]])
            {
                PlayingCard *card =(PlayingCard *)matchCard;
                NSString *append = ([cards count])?(([cards count]>1)?@",":@" 和 "): @"";
                [cardText appendFormat:@"%@%@",card.contents,append];
                
            }
        }
        [history addObject:[[NSString alloc]initWithFormat:@"%@ 不匹配!",cardText]];
    }
    self.history = history;//重写历史纪录
    return score;
}


-(NSString *)contents
{
    
    NSArray *rankString =[ PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
    
}
@synthesize suit = _suit;
@synthesize rank = _rank;
+(NSArray*)validSuits
{
        return @[@"红桃",@"方片",@"黑桃",@"梅花"];
    }
+(NSArray *)rankStrings
{
    
        return @[@"?",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    }
+(NSUInteger)maxRank
{
        return [[self rankStrings] count]-1;
}
-(void)setRank:(NSUInteger)rank;
{
        if(rank<=[PlayingCard maxRank]){
        _rank = rank;
        
    }
}

-(void)setSuit:(NSString *)suit
{
        if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
        
        
    }
}
-(NSString *)suit
{
    return _suit ? _suit :@"?";
}
@end
