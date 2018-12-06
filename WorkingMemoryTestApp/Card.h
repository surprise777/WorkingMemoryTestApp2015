//
//  Card.h
//  WorkingMemoryTestApp
//
//  Created by 晶琦 张 on 15/11/7.
//  Copyright © 2015年 晶琦 张. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property(strong,nonatomic) NSString *contents;

@property(nonatomic,getter=isChosen) BOOL chosen;

@property(nonatomic,getter=isMatched) BOOL matched;
-(int)match:(NSArray *)otherCards;
-(NSArray *)matchHistory;

@end

