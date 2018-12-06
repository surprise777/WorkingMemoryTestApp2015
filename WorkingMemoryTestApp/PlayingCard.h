//
//  PlayingCard.h
//  WorkingMemoryTestApp
//
//  Created by 晶琦 张 on 15/11/8.
//  Copyright © 2015年 晶琦 张. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property(strong,nonatomic) NSString *suit;

@property(nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;

+(NSUInteger )maxRank;
@end
