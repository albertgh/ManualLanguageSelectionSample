//
//  ViewController.m
//  ManualLanguageSelectionSample
//
//  Created by Albert Chu on 14/11/27.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import "ViewController.h"

#import "SettingsViewController.h"


@interface ViewController ()

@end


@implementation ViewController

#pragma mark - Action

- (void)languageButtonTapped:(UIBarButtonItem *)sender {
    SettingsViewController *userPageVC = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:userPageVC animated:YES];
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = NSLocalizedString(@"Sample", nil);
    
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Language", nil)
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(languageButtonTapped:)];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = self.view.bounds;
    
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont boldSystemFontOfSize:40.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.text = NSLocalizedStringWithDefaultValue(@"a2a_d2d", nil, [self some3rdBundle], @"", @"");
    
    
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Some3rdBundle

- (NSBundle*)some3rdBundle {
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"3rdLib" ofType:@"bundle"]];
}


@end
