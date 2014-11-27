## ACLanguageUtil

Manual Language Selection Sample


## Installing

```
Drag ACLanguageUtil folder into your project. 
```

```objective-c
#import "ACLanguageUtil.h" at your PrefixHeader.pch  
```


## Usage

* Set Language

```objc
[[ACLanguageUtil sharedInstance] setLanguage:language];
```

You need to recreate the whole UI to see the change.
Like reset `self.window.rootViewController` in your `AppDelegate`.


#### Requirements

* ARC



#### License

* WTFPL 


