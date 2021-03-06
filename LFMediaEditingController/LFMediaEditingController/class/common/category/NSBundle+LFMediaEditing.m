//
//  NSBundle+LFMediaEditing.m
//  LFMediaEditingController
//
//  Created by TsanFeng Lam on 2018/3/15.
//  Copyright © 2018年 LamTsanFeng. All rights reserved.
//

#import "NSBundle+LFMediaEditing.h"
#import "LFBaseEditingController.h"

NSString *const LFMediaEditingStrings = @"LFMediaEditingController";

@implementation NSBundle (LFMediaEditing)

+ (instancetype)LF_mediaEditingBundle
{
    static NSBundle *lfMediaEditingBundle = nil;
    if (lfMediaEditingBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        lfMediaEditingBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[LFBaseEditingController class]] pathForResource:@"LFMediaEditingController" ofType:@"bundle"]];
    }
    return lfMediaEditingBundle;
}

+ (UIImage *)LFME_imageNamed:(NSString *)name inDirectory:(NSString *)subpath
{
    //  [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", kBundlePath, name]]
    NSString *extension = name.length ? (name.pathExtension.length ? name.pathExtension : @"png") : nil;
    NSString *defaultName = [name stringByDeletingPathExtension];
    NSString *bundleName = [defaultName stringByAppendingString:@"@2x"];
    //    CGFloat scale = [UIScreen mainScreen].scale;
    //    if (scale == 3) {
    //        bundleName = [name stringByAppendingString:@"@3x"];
    //    } else {
    //        bundleName = [name stringByAppendingString:@"@2x"];
    //    }
    UIImage *image = [UIImage imageWithContentsOfFile:[[self LF_mediaEditingBundle] pathForResource:bundleName ofType:extension inDirectory:subpath]];
    if (image == nil) {
        image = [UIImage imageWithContentsOfFile:[[self LF_mediaEditingBundle] pathForResource:defaultName ofType:extension inDirectory:subpath]];
    }
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (UIImage *)LFME_imageNamed:(NSString *)name
{
    return [self LFME_imageNamed:name inDirectory:nil];
}

+ (UIImage *)LFME_stickersImageNamed:(NSString *)name
{
    return [self LFME_imageNamed:name inDirectory:@"stickers"];
}

+ (UIImage *)LFME_audioTrackImageNamed:(NSString *)name
{
    return [self LFME_imageNamed:name inDirectory:@"AudioTrack"];
}

+ (UIImage *)LFME_brushImageNamed:(NSString *)name
{
    return [self LFME_imageNamed:name inDirectory:@"brush"];
}

+ (NSString *)LFME_stickersPath
{
    return [[self LF_mediaEditingBundle] pathForResource:@"stickers" ofType:nil];
}

+ (NSString *)LFME_localizedStringForKey:(NSString *)key
{
    return [self LFME_localizedStringForKey:key value:nil];
}
+ (NSString *)LFME_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    value = [[self LF_mediaEditingBundle] localizedStringForKey:key value:value table:LFMediaEditingStrings];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:LFMediaEditingStrings];
}

@end
