//
//  ACLanguageUtil.h
//
//  Created by Albert Chu on 14/11/27.
//

#import <Foundation/Foundation.h>


#undef NSLocalizedString
#define NSLocalizedString(key, comment) \
[[ACLanguageUtil sharedInstance] localizedStringForKey:key]

#undef NSLocalizedStringWithDefaultValue
#define NSLocalizedStringWithDefaultValue(key, tbl, bundle, val, comment) \
[[[ACLanguageUtil sharedInstance] manualLanguagebundle:bundle] localizedStringForKey:(key) value:(val) table:(tbl)]


static NSString * const ACLanguageUtilLanguageIdentifier = @"ACLanguageUtilLanguageIdentifier";

@interface ACLanguageUtil : NSObject

@property (nonatomic, retain) NSString *currentLanguage;

+ (ACLanguageUtil*)sharedInstance;

- (void)setLanguage:(NSString *)language;

- (NSBundle *)manualLanguagebundle:(NSBundle *)bundle;

- (NSString *)localizedStringForKey:(NSString *)key;

@end
