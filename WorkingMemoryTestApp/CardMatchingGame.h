//
//  CardMatchingGame.h
//  WorkingMemoryTestApp
//
//  Created by 晶琦 张 on 15/11/8.
//  Copyright © 2015年 晶琦 张. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSArray *)matchHistory;
@property (nonatomic)NSInteger gameType;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readwrite) NSInteger vancancymatchscore;
@property(nonatomic,readonly) NSInteger endingflag;
@end
