//
//  ACLanguageUtil.m
//
//  Created by Albert Chu on 14/11/27.
//

#import "ACLanguageUtil.h"

@implementation ACLanguageUtil

#pragma mark - Singleton

+ (ACLanguageUtil*)sharedInstance {
    static ACLanguageUtil *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ACLanguageUtil alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Public

- (void)setLanguage:(NSString *)language {
    self.currentLanguage = language;
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:ACLanguageUtilLanguageIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSBundle *)manualLanguagebundle:(NSBundle *)bundle {
    NSBundle *newBundle = bundle;
    
    NSString *currentLanguageString = [[NSUserDefaults standardUserDefaults] objectForKey:ACLanguageUtilLanguageIdentifier];
    
    // path to this languages bundle
    NSString *path = [bundle pathForResource:currentLanguageString ofType:@"lproj" ];
    
    if (path) {
        newBundle = [NSBundle bundleWithPath:path];
    }
    
    return newBundle;
}

- (NSString *)localizedStringForKey:(NSString *)key {
    return  [[self manualLanguagebundle:[NSBundle mainBundle]] localizedStringForKey:(key) value:@"" table:nil];
}

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        NSString *currentLanguageString = [[NSUserDefaults standardUserDefaults] objectForKey:ACLanguageUtilLanguageIdentifier];
        if (currentLanguageString.length > 0) {
            self.currentLanguage = currentLanguageString;
        }
        else {
            // first init
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
            NSString* currentLanguage = languages[0];
            
            BOOL isSupport = NO;
            NSArray *supportLanguagesArray = @[@"zh-Hans", @"zh-Hant", @"en"];
            for (NSString *languageCodeString in supportLanguagesArray) {
                if ([currentLanguage isEqualToString:languageCodeString]) {
                    isSupport = YES;
                    break;
                }
            }
            
            // use english default
            NSString *setToLanguageCodeString = @"en";
            if (isSupport) {
                setToLanguageCodeString = currentLanguage;
            }
            
            [self setLanguage:setToLanguageCodeString];
        }
    }
    return self;
}

@end
