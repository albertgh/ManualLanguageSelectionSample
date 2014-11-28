//
//  ACLanguageUtil.m
//
//  Created by Albert Chu on 14/11/27.
//

#import "ACLanguageUtil.h"


static NSString * const ACLanguageUtilDefaultLanguage   = @"en";

static NSString * const ACLanguageUtilSupportLanguages  = @"en, zh-Hans, zh-Hant";


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
    if ([self doSupportTheNewLanguage:language]) {
        self.currentLanguage = language;
        [[NSUserDefaults standardUserDefaults] setObject:language forKey:ACLanguageUtilLanguageIdentifier];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - For Macros

- (NSString *)localizedStringForKey:(NSString *)key {
    return  [[self manualLanguageBundle:[NSBundle mainBundle]] localizedStringForKey:(key) value:@"" table:nil];
}

- (NSString *)localizedStringForKey:(NSString *)key fromTable:(NSString *)table {
    return  [[self manualLanguageBundle:[NSBundle mainBundle]] localizedStringForKey:(key) value:@"" table:table];
}

- (NSBundle *)manualLanguageBundle:(NSBundle *)bundle {
    NSBundle *newBundle = bundle;
    
    NSString *currentLanguageString = [[NSUserDefaults standardUserDefaults] objectForKey:ACLanguageUtilLanguageIdentifier];
    
    // path to this languages bundle
    NSString *path = [bundle pathForResource:currentLanguageString ofType:@"lproj" ];
    
    if (path) {
        newBundle = [NSBundle bundleWithPath:path];
    }
    
    return newBundle;
}

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        NSString *currentLanguageString =
        [[NSUserDefaults standardUserDefaults] objectForKey:ACLanguageUtilLanguageIdentifier];
        if (currentLanguageString.length > 0) {
            self.currentLanguage = currentLanguageString;
        }
        else {
            // first init
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
            NSString *currentLanguage = languages[0];
            
            // use english default
            NSString *newLanguage =
            [ACLanguageUtilDefaultLanguage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([self doSupportTheNewLanguage:currentLanguage]) {
                newLanguage = currentLanguage;
            }
            
            [self setLanguage:newLanguage];
        }
    }
    return self;
}

#pragma mark - Private

- (BOOL)doSupportTheNewLanguage:(NSString *)newLanguage {
    NSArray *supportLanguagesArray = [ACLanguageUtilSupportLanguages componentsSeparatedByString:@","];
    for (NSString *language in supportLanguagesArray) {
        NSString *cleanLanguage = [language stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([newLanguage isEqualToString:cleanLanguage]) {
            return YES;
        }
    }
    return NO;
}

@end
