//
//  ViewController.m
//  SHCheckInfoView
//
//  Created by lvshaohua on 2017/5/19.
//  Copyright © 2017年 lvshaohua. All rights reserved.
//

#import "ViewController.h"
#import "SHCheckInfoView.h"

@interface ViewController ()
@property (nonatomic, retain) SHCheckInfoView *checkView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.checkView = [[SHCheckInfoView alloc] initWithFrame:CGRectMake(0, 0, 40, 40) lineWidth:2 lineColor:[UIColor redColor]];
    self.checkView.center = self.view.center;
    [self.view addSubview:self.checkView];
}

- (IBAction)onRightBtnAction:(id)sender {
    [self.checkView showAnimationWithState:XYProgressResult_Success duration:1.5 complete:nil];
}
- (IBAction)onFailedBtnAction:(id)sender {
    [self.checkView showAnimationWithState:XYProgressResult_Failed duration:1.5 complete:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
