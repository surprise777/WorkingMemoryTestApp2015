//
//  ViewController.h
//  WorkingMemoryTestApp
//
//  Created by 晶琦 张 on 15/11/1.
//  Copyright © 2015年 晶琦 张. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController : UIViewController<
UIAlertViewDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property(nonatomic,readwrite)NSInteger *flag;
@property (weak, nonatomic) IBOutlet UILabel *mytimer;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControlButton;
@property (weak, nonatomic) IBOutlet UISlider *gameHistorySlider;

@property (weak, nonatomic) IBOutlet UITextView *gameHistory;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong,nonatomic) CardMatchingGame *game;
@property (strong,nonatomic) Deck *deck;
-(Deck *)createDeck;
@end

