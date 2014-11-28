## ACLanguageUtil

Manual Language Selection Sample
 
By redefining all four `NSLocalizedString` `NSLocalizedStringFromTable` `NSLocalizedStringFromTableInBundle` `NSLocalizedStringWithDefaultValue` macros,
 
so that you can make your project able to select language manually 
 
without change any other code even 3rd party code. 
 

## Installing


Drag `ACLanguageUtil` folder into your project. 


```objective-c
#import "ACLanguageUtil.h" in your PrefixHeader.pch  
```


## Usage

* Default Language & Support Languages
 
You should replace the value of `ACLanguageUtilSupportLanguages` to your own language list in `ACLanguageUtil.m` at line 12. 
 
In case of other languages that your project doesn't support will be set to some default language.
 
And the default language is `ACLanguageUtilDefaultLanguage` at line 10, you may replace the value of it too.
 
```objc
static NSString * const ACLanguageUtilDefaultLanguage = @"en";

static NSString * const ACLanguageUtilSupportLanguages = @"en,zh-Hans,zh-Hant";
```

* Set Language

```objc
NSString *newLanguage = @"zh-Hans";

[[ACLanguageUtil sharedInstance] setLanguage:newLanguage];
```
 
After that you need to recreate the whole UI to see the change.

Like reset `self.window.rootViewController` in your `AppDelegate.m`.
 
 

#### Requirements

* ARC



#### License

* WTFPL 


