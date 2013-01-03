//
//  HtmlArticle.m
//  VoiceApp
//
//  Created by Flloyd Pauline Kennedy on 1/01/13.
//  Copyright (c) 2013 Flloyd Pauline Kennedy. All rights reserved.
//

#import "HtmlArticle.h"

@implementation HtmlArticle

-(id) initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        _filename=name;
        return self;
    }
    return nil;
}
@end
