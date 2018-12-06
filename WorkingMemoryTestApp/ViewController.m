//
//  ViewController.m
//  WorkingMemoryTestApp
//
//  Created by 晶琦 张 on 15/11/1.
//  Copyright © 2015年 晶琦 张. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
{
    UIImage* frontImage;
}
//@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;

//@property ( nonatomic) int flipCount//
@property(nonatomic,retain) NSTimer *timer;
@end


@implementation ViewController

NSString *cardsToMatch=@"文本";
int existFlag=0;
-(CardMatchingGame *)game
{
    if(!_game)_game =[[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck: [self createDeck]];
    return _game;
}
//- (Deck *)deck
//{if (!_deck){        _deck = [self createDeck];    }return _deck;//

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}
//- (IBAction)TouchButtonGame:(UIButton *)sender {
  //  NSUInteger cardIndex = [self.CardButtons indexOfObject:sender];
    //[self.game chooseCardAtIndex:cardIndex];
    //[self updateUI];
//}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.gameTypeControlButton.enabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    NSArray *lastMatchHistory = [[self.game matchHistory] lastObject];
    self.gameHistory.text = [lastMatchHistory componentsJoinedByString:@"\n"];
    [self updateUI];
    if(self.game.vancancymatchscore==0)
    {
    UIAlertView *warning = [[UIAlertView alloc] initWithTitle:@"Game Over"message:@"您已经没有可匹配的牌了！"delegate:self cancelButtonTitle:nil
                                            otherButtonTitles: @"finished", nil];
        [forthtimer invalidate];
        [secondtimer invalidate];
        self.gameTypeControlButton.enabled=NO;
        for (UIButton *cardButton in self.cardButtons)
        {
            cardButton.enabled =NO;
        }
        [warning show];
    }
    if(self.game.endingflag==16)
    {     UIAlertView *warning = [[UIAlertView alloc] initWithTitle:@"Win!"
                                                            message:@"恭喜！您已经匹配所有的牌！"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"finished", nil];
        [forthtimer invalidate];
        [secondtimer invalidate];
        self.gameTypeControlButton.enabled=NO;
            for (UIButton *cardButton in self.cardButtons)
            {
                cardButton.enabled =NO;
            }
        [warning show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"好!"])
        self.mytimer.text=@"0";
    [secondtimer invalidate];
//    for (UIButton *cardButton in self.cardButtons)
//    {
//        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
//        Card *card = [self.game cardAtIndex:cardButtonIndex];
//        [cardButton setTitle:card.contents forState:UIControlStateNormal];
//        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
//        cardButton.enabled =NO;
//    }
    //self.gameTypeControlButton.enabled=YES;
    [self test];
    }
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateGameHistorySlider];
//    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/test.txt"];
//    NSFileManager *manager;
//    manager=[NSFileManager defaultManager];
//    if([manager fileExistsAtPath:path])
//    {
//        existFlag=1;
//    }
}
-(void)updateGameHistorySlider
{
    int count = (int)[[self.game matchHistory]count] -1;
    self.gameHistorySlider.maximumValue = count;
    self.gameHistorySlider.value = self.gameHistorySlider.maximumValue;
    self.gameHistorySlider.enabled = (count>1)? YES : NO;
    
}
- (IBAction)slideThroughHistory {
    int element = (int) round(self.gameHistorySlider.value);
    if (element < 0)element = 0;
    NSArray *history = [[self.game matchHistory]objectAtIndex:element];
    self.gameHistory.text = [history componentsJoinedByString:@"\n"];
    if (element == self.gameHistorySlider.maximumValue)
    {
        self.gameHistory.textColor = [UIColor yellowColor];
    }
    else
    {
        self.gameHistory.textColor = [UIColor redColor];
    }
    
}

- (IBAction)changeGameType:(UISegmentedControl *)sender {
    cardsToMatch =(self.gameTypeControlButton.selectedSegmentIndex)?@"图像":@"文本";
    NSString *test =[[NSString alloc]initWithFormat:@" 现在您以 %@ 模式完成游戏",cardsToMatch];
    UIAlertView *feedback = [[UIAlertView alloc]initWithTitle:@"游戏模式改变" message:test delegate:nil cancelButtonTitle:@"good!" otherButtonTitles:nil];
    [feedback show];
    if ([[feedback buttonTitleAtIndex:feedback.cancelButtonIndex] isEqualToString:@"good!"])
    {
        
//        timingFlag=1;
        
        if([cardsToMatch isEqualToString:@"文本"])
        {   [thirdtimer invalidate];
            [self firstimer];
            for (UIButton *cardButton in self.cardButtons)
            {
                NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
                Card *card = [self.game cardAtIndex:cardButtonIndex];
                [cardButton setTitle:card.contents forState:UIControlStateNormal];
                [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
                cardButton.enabled = !card.isMatched;
            }
           // [firsttimer invalidate];
            //[self firstimer];
           //  [self test];
        }
        else
        {    [firsttimer invalidate];
            [self thirdtimer];
            for (UIButton *cardButton in self.cardButtons)
            {
                NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
                Card *card = [self.game cardAtIndex:cardButtonIndex];
               [cardButton setTitle:nil forState:UIControlStateNormal];
                [cardButton setBackgroundImage:[UIImage imageNamed:card.contents] forState:UIControlStateNormal];
                cardButton.enabled = !card.isMatched;
            }
            
          //  [self test];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
 //   [self initFile];
    if([cardsToMatch isEqualToString:@"文本"])
    {
        for (UIButton *cardButton in self.cardButtons)
        {
            NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
            Card *card = [self.game cardAtIndex:cardButtonIndex];
            if ([card.contents containsString:@"梅花"] || [card.contents containsString:@"黑桃"])
            {
                [cardButton setTitleColor:[UIColor blackColor]forState: UIControlStateNormal];
            }
            
            [cardButton setTitle:card.contents forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
            cardButton.enabled = !card.isMatched;
         }
       [self firstimer];
       
    }
    else
    {
        [firsttimer invalidate];
        [secondtimer invalidate];
        for (UIButton *cardButton in self.cardButtons)
       {
         NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
           Card *card = [self.game cardAtIndex:cardButtonIndex];
 //   [cardButton setTitle:card.contents forState:UIControlStateNormal];
           [cardButton setBackgroundImage:[UIImage imageNamed:card.contents] forState:UIControlStateNormal];
           cardButton.enabled = !card.isMatched;
        }
  [self thirdtimer];
    }
}
//-(void)initFile
//{
    
 //   NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/test.txt"];
//     NSString *str=@" ";
 //   [str writeToFile:path atomically:true encoding:NSUnicodeStringEncoding error:nil];
//}
-(void)test
{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
        path=[path stringByAppendingString:@"test.txt"];
   NSFileManager *manager=[NSFileManager defaultManager];
 if( ![manager fileExistsAtPath:path])
 {
     NSString *init=@" ";
     [init writeToFile:path atomically:true encoding:NSUTF8StringEncoding error:nil];
 }
    NSLog(@"%@", path);

        NSFileHandle *fh = [NSFileHandle fileHandleForUpdatingAtPath:path];
    NSString *str;
    if([cardsToMatch isEqualToString:@"文本"])
    {
        str =
        [[NSString alloc]initWithFormat:@"Literal, score: %ld ",self.game.score];
    }
    else
    {
        str =
        [[NSString alloc]initWithFormat:@"Pictorial, score: %ld ",self.game.score];
    }
    //   [fh synchronizeFile];
    //以只写的方式打开指定位置的文件，创建文件句柄//当我们以只写形式打开一个文件的时候，文件的内容全都在，并未被清空，我们写入的内容会直接覆盖原内容（与C语言不同）
    //   [fh writeData:[@"hello" dataUsingEncoding:NSUTF8StringEncoding]];//以NSData的形式写入//以C语言文件控制-w方式写入（清空再写入）
    //   [fh truncateFileAtOffset:0];//将文件内容截短至0字节(清空)
    //  [fh writeData:[@"hello" dataUsingEncoding:NSUnicodeStringEncoding]];//这样就相当于按-w方式写入//以C语言文件控制-a方式写入（保持原来文件内容不变，向后追加）
    str=[str stringByAppendingString:@"\n"];
    [fh seekToEndOfFile];//将读写指针设置在文件末尾
    [fh writeData:[str dataUsingEncoding:NSUnicodeStringEncoding]];
 //   NSLog(path);
    
        }

- (void) updateUI {
    if([cardsToMatch isEqualToString:@"文本"])
    {
        for (UIButton *cardButton in self.cardButtons)
        {
       
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];

        
        [cardButton setTitle:[ self titleForCard:card ] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    
        }
    self.scoreLabel.text =[NSString stringWithFormat:@"Score:%ld",(long)self.game.score];
     [self updateGameHistorySlider];
    }
    else
    {
        for (UIButton *cardButton in self.cardButtons)
        {
            NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
            Card *card = [self.game cardAtIndex:cardButtonIndex];
           // [cardButton setTitle:nil forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
            cardButton.enabled = !card.isMatched;
        }
        self.scoreLabel.text =[NSString stringWithFormat:@"Score:%ld",(long)self.game.score];
        [self updateGameHistorySlider];

    }
}


 //   if([sender.currentTitle length]){
    
 //       [sender setBackgroundImage:[UIImage imageNamed:@"background1"]
 //                         forState:UIControlStateNormal];
        
//    [sender setTitle:@""forState:UIControlStateNormal];
  //    self.flipCount++;
  //  }else{
    //    Card*card=[self.deck drawRandomCard];
    //    if (card){
     //   [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
      //                    forState:UIControlStateNormal];
        
   // [sender setTitle:card.contents forState:UIControlStateNormal];
     // self.flipCount++;
   //     }
  //  }
   
    

- (NSString *)titleForCard:(Card *)card{
return  card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    if ([cardsToMatch isEqualToString:@"文本"]) {
        return  [UIImage imageNamed:card.isChosen ? @"cardfront":@"cardback"];
    }
    else
    {
        return  [UIImage imageNamed:card.isChosen ?card.contents: @"cardback"];
    }
}

int flag1=0;
int flag2=0;
int firstTimeTick=20;
int SecondTimeTick=60;
NSTimer *firsttimer;
NSTimer *secondtimer;
int ThirdTimeTick=20;
int ForthTimeTick=60;
NSTimer *thirdtimer;
NSTimer *forthtimer;

-(void)firstimer{
//20秒倒计时
    flag1 = 0;
firsttimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}
-(void)secondtimer{
    //60秒倒计时
    flag1=1;
    secondtimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}
-(void)thirdtimer{
    //6秒倒计时
    flag2 = 0;
    thirdtimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}
-(void)forthtimer{
    //60秒倒计时
    flag2=1;
    forthtimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}
-(void)timeFireMethod
{
    if([cardsToMatch isEqualToString:@"文本"])//文本组
    {
        [thirdtimer invalidate];
        [forthtimer invalidate];
        if(flag1==0)//20s
        {
            firstTimeTick--;
            if(firstTimeTick==0)//out of 20s
            {
                [firsttimer invalidate];
                [secondtimer invalidate];
                for (UIButton *cardButton in self.cardButtons)
                {
                    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
                    Card *card = [self.game cardAtIndex:cardButtonIndex];
                    [cardButton setTitle:[ self titleForCard:card ] forState:UIControlStateNormal];
                    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
                    cardButton.enabled = !card.isMatched;
                }
                self.mytimer.text=@"0";
               [self secondtimer];
            }
            else//in 20s
            {
                for (UIButton *cardButton in self.cardButtons)
                {
                    cardButton.enabled = NO;
                }
                NSString *str = [NSString stringWithFormat:@"%d秒",firstTimeTick];
                self.mytimer.text=str;
            }
        }
        else//60s
        {    self.gameTypeControlButton.enabled=NO;
            SecondTimeTick--;
            if(SecondTimeTick==0)//out of 60s
            {
                [self test];
                [secondtimer invalidate];
                [firsttimer invalidate];
                for (UIButton *cardButton in self.cardButtons)
                {
                    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
                    Card *card = [self.game cardAtIndex:cardButtonIndex];
                              [cardButton setTitle:[ self titleForCard:card ] forState:UIControlStateNormal];
                    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
                    cardButton.enabled = NO;
                }
                self.mytimer.text=@"0";
            }
            else//in 60s
            {
                NSString *str = [NSString stringWithFormat:@"%d秒",SecondTimeTick];
                self.mytimer.text=str;
            }
        }
    }
    else//图像组
    {
        [firsttimer invalidate];
        [secondtimer invalidate];
        //[thirdtimer invalidate];
        //[forthtimer invalidate];
        if(flag2==0)//20s
        {
            //[firsttimer invalidate];
            //[secondtimer invalidate];
            ThirdTimeTick--;
            if(ThirdTimeTick==0)//out of 20s
            {
                [thirdtimer invalidate];
                for (UIButton *cardButton in self.cardButtons)
                {
                    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
                    Card *card = [self.game cardAtIndex:cardButtonIndex];
                    [cardButton setTitle:[ self titleForCard:card ] forState:UIControlStateNormal];
                    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
                    cardButton.enabled = !card.isMatched;
                }
                self.mytimer.text=@"0";
                if(ForthTimeTick >= 0)[self forthtimer];
            }
            else//in 20s
            {
                for (UIButton *cardButton in self.cardButtons)
                {
                    [cardButton setTitle:nil forState:UIControlStateNormal];
                    cardButton.enabled = NO;
                }
                [firsttimer invalidate];
                [secondtimer invalidate];
                NSString *str = [NSString stringWithFormat:@"%d秒",ThirdTimeTick];
                self.mytimer.text=str;
            }
        }
        else//60s
        {   self.gameTypeControlButton.enabled=NO;
            [firsttimer invalidate];
            [secondtimer invalidate];
            ForthTimeTick--;
            if(ForthTimeTick==0)//out of 60s
            {
                [self test];
            
                [thirdtimer invalidate];
                [secondtimer invalidate];
                [firsttimer invalidate];
                [forthtimer invalidate];
                for (UIButton *cardButton in self.cardButtons)
                {
                    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
                    Card *card = [self.game cardAtIndex:cardButtonIndex];
                    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
                    cardButton.enabled = NO;
                }
                [firsttimer invalidate];
               [secondtimer invalidate];
                self.mytimer.text=@"0";
            }
            else//in 60s
            {
                [firsttimer invalidate];
                [secondtimer invalidate];
                //[thirdtimer invalidate];
                NSString *str = [NSString stringWithFormat:@"%d秒",ForthTimeTick];
                self.mytimer.text=str;
            }
        }
    }
}

@end
    //-(void)setFlipCount:(int)flipCount
//{
 //   _flipCount =flipCount;
  //  self.flipsLabel.text = [NSString stringWithFormat:@"Flips:%d",self.flipCount];
    //NSLog(@"%d",self.flipCount);
//}
    


