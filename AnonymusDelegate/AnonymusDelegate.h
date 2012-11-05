//
//  BDAnonymusDelegate.h
//  BlockDelegate
//
//  Created by Bruno Berisso on 30/10/12.
//  Copyright (c) 2012 Bruno Berisso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnonymusDelegate

bool addImplForProtocolWithBlock(Class c, Protocol *p, SEL s, id block);
id addDynamicImplWithBlock(id<NSObject> obj, SEL s, id block, ...);

@end

#define dynProtocol(s, b, ...) addDynamicImplWithBlock(self, s, b, __VA_ARGS__)

