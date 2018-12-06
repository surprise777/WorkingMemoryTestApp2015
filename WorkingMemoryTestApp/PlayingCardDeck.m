//
//  PlayingCardDeck.m
//  WorkingMemoryTestApp
//
//  Created by 晶琦 张 on 15/11/7.
//  Copyright © 2015年 晶琦 张. All rights reserved.
//


#import"PlayingCardDeck.h"
#import"PlayingCard.h"


@implementation PlayingCardDeck
-(instancetype)init
{
    self =[super init];
    
    if (self)
    {
        for (NSString *suit in [PlayingCard validSuits])
        {
            for (NSUInteger rank = 1;rank<=[PlayingCard maxRank];rank++)
            {
                PlayingCard *card =[[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
    
            }
        }
    }
    return self;
}
@end
