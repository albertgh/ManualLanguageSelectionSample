//
//  SettingsViewController.m
//  ManualLanguageSelectionSample
//
//  Created by Albert Chu on 14/11/27.
//  Copyright (c) 2014年 Albert Chu. All rights reserved.
//

#import "SettingsViewController.h"


@interface SettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView           *tableView;

@property (nonatomic, retain) NSString              *switchToLanguageCodeString;

@property (nonatomic, assign) NSInteger             selectedRow;

@end


@implementation SettingsViewController


#pragma mark - Action

- (void)switchButtonTapped:(UIBarButtonItem *)sender {
    if (![self.switchToLanguageCodeString isEqualToString:[ACLanguageUtil sharedInstance].currentLanguage]) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [appDelegate reDrawAllUIForLanguage:self.switchToLanguageCodeString];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Settings", nil);

    [self createTableView];

}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *DoNotReuseIdentifier =
    [NSString
     stringWithFormat:@"LanguageCellIdentifier__%ld__%ld",
     (long)indexPath.section,
     (long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DoNotReuseIdentifier];
    
    if ( nil == cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DoNotReuseIdentifier];
    }
    
    
    // config cell
    NSString *languageString = @"";
    
    NSString *languageCodeString = @"";
    
    switch (indexPath.row) {
        case 0: {
            languageString = @"简体中文";
            languageCodeString = @"zh-Hans";
        }
            break;
        case 1: {
            languageString = @"繁體中文";
            languageCodeString = @"zh-Hant";
        }
            break;
        case 2: {
            languageString = @"English";
            languageCodeString = @"en";
        }
            break;
            
        default:
            break;
    }
    
    cell.textLabel.text = languageString;
    
    NSString *currentLanguageString = [[NSUserDefaults standardUserDefaults] objectForKey:ACLanguageUtilLanguageIdentifier];
    if ([languageCodeString isEqualToString:currentLanguageString]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedRow = indexPath.row;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(switchButtonTapped:)];
    
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedRow inSection:0]];
    selectedCell.accessoryType = UITableViewCellAccessoryNone;
    
    UITableViewCell *newSelectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectedRow = indexPath.row;
    
    switch (indexPath.row) {
        case 0: {
            newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.switchToLanguageCodeString = @"zh-Hans";
        }
            break;
        case 1: {
            newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.switchToLanguageCodeString = @"zh-Hant";
        }
            break;
        case 2: {
            newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.switchToLanguageCodeString = @"en";
        }
            break;
            
        default:
            break;
    }
    
}


@end
