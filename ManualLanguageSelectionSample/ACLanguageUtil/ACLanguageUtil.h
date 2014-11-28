//
//  ACLanguageUtil.h
//
//  Created by Albert Chu on 14/11/27.
//

#import <Foundation/Foundation.h>


#undef NSLocalizedString
#define NSLocalizedString(key, comment) \
[[ACLanguageUtil sharedInstance] localizedStringForKey:(key)]

#undef NSLocalizedStringFromTable
#define NSLocalizedStringFromTable(key, tbl, comment) \
[[ACLanguageUtil sharedInstance] localizedStringForKey:(key) fromTable:(tbl)]

#undef NSLocalizedStringFromTableInBundle
#define NSLocalizedStringFromTableInBundle(key, tbl, bundle, comment) \
[[[ACLanguageUtil sharedInstance] manualLanguageBundle:(bundle)] localizedStringForKey:(key) value:@"" table:(tbl)]

#undef NSLocalizedStringWithDefaultValue
#define NSLocalizedStringWithDefaultValue(key, tbl, bundle, val, comment) \
[[[ACLanguageUtil sharedInstance] manualLanguageBundle:(bundle)] localizedStringForKey:(key) value:(val) table:(tbl)]


static NSString * const ACLanguageUtilLanguageIdentifier = @"ACLanguageUtilLanguageIdentifier";

@interface ACLanguageUtil : NSObject

@property (nonatomic, retain) NSString *currentLanguage;

+ (ACLanguageUtil*)sharedInstance;

- (void)setLanguage:(NSString *)language;


#pragma mark - For Macros

- (NSString *)localizedStringForKey:(NSString *)key;
- (NSString *)localizedStringForKey:(NSString *)key fromTable:(NSString *)table;
- (NSBundle *)manualLanguageBundle:(NSBundle *)bundle;

@end
