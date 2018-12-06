//
//  Deck.h
//  WorkingMemoryTestApp
//
//  Created by 晶琦 张 on 15/11/7.
//  Copyright © 2015年 晶琦 张. All rights reserved.
//

#import<Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;
@end
