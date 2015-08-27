//
//  Custom.m
//  30_Uchenik
//
//  Created by Nikolay Sozinov on 27.08.15.
//  Copyright (c) 2015 Nikolay Sozinov. All rights reserved.
//

#import "Custom.h"

@implementation Custom


- (id) init
{  self = [super init];
    if (self) {
        self.color = [UIColor whiteColor];
        self.name = @"New row";
    }
    return  self;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"name = %@", self.name];

}
@end

