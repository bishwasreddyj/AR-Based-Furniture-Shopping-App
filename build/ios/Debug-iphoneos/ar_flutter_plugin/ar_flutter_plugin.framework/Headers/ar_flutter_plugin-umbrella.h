#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ArFlutterPlugin.h"

FOUNDATION_EXPORT double ar_flutter_pluginVersionNumber;
FOUNDATION_EXPORT const unsigned char ar_flutter_pluginVersionString[];

