//
//  VardMatchingGame.m
//  WorkingMemoryTestApp
//
//  Created by 晶琦 张 on 15/11/8.
//  Copyright © 2015年 晶琦 张. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic,strong)NSMutableArray *history;
@end
@implementation CardMatchingGame
- (NSMutableArray *)history {
    if (!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}
- (NSArray *)matchHistory {
    return self.history;
}
- (NSMutableArray *)cards{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard]; 
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY =2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{   _endingflag=0;
    Card *card = [self cardAtIndex:index];
    
  if (!card.isMatched)
  {
    if (card.isChosen)
    {
            card.chosen = NO;
           NSString *feedback = [[NSString alloc] initWithFormat:@"取消选择 %@", card.contents];
             [self.history addObject:@[feedback]];
    }
    else
    {   NSMutableArray *matchedCards = [[NSMutableArray alloc]init];
        NSMutableArray *vancancymatchedCards = [[NSMutableArray alloc] init];
            _vancancymatchscore=0;
       for (Card *otherCard in self.cards)
       {
         if(!otherCard.isMatched)
            {
                    [vancancymatchedCards addObject:otherCard];
                    _vancancymatchscore += [card match:vancancymatchedCards];
            }
         if (otherCard.isChosen && !otherCard.isMatched)
        {
                [matchedCards addObject:otherCard];
        }
           
       }
        if([matchedCards count]==1)
        {  int matchScore = [card match:matchedCards];
                if (matchScore)
                {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                    
                       for ( Card *otherCard in matchedCards)
                       {
                           otherCard.matched = YES;
                       }
                    
              [self.history addObject:[card matchHistory]];
                }
                else
                {
                    long penalty = MISMATCH_PENALTY;                    self.score -= MISMATCH_PENALTY;
            for(Card *otherCard in matchedCards)
            {
                otherCard.chosen = NO;
            }
                    NSString *matchHistory = card.matchHistory.lastObject;
                        NSString *feedback = [matchHistory stringByAppendingFormat:@"扣 %ld 分!",penalty];
                [self.history addObject:@[feedback]];
                }
             }
        else{
           NSString *feedback = [[NSString alloc] initWithFormat:@"选择了 %@", card.contents];
        [self.history addObject:@[feedback]];
        }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
       }
    } 
  
    for(Card *endingcard in self.cards)
    {
        if(endingcard.isMatched==YES)
            _endingflag++;
    }
}
@end
