//
//  BDAnonymusDelegate.m
//  BlockDelegate
//
//  Created by Bruno Berisso on 30/10/12.
//  Copyright (c) 2012 Bruno Berisso. All rights reserved.
//

#import "AnonymusDelegate.h"
#import <objc/runtime.h>

typedef struct objc_method_description MethodDescription;

@implementation AnonymusDelegate

bool addImplForProtocolWithBlock(Class c, Protocol *p, SEL s, id block) {
    
    MethodDescription md = protocol_getMethodDescription(p, s, YES, YES);
    
    if (md.name == NULL)
        md = protocol_getMethodDescription(p, s, NO, YES);
    
    if (md.name != NULL) {
        IMP blockImp = imp_implementationWithBlock(block);
        return class_addMethod(c, md.name, blockImp, md.types);
    }
    
    return false;
}

id addDynamicImplWithBlock(id<NSObject> obj, SEL s, id block, ...) {
    
    Class c = [obj class];
    unsigned int protocolCount = 0;
    Protocol * __unsafe_unretained *protocolList = class_copyProtocolList(c, &protocolCount);
    
    for (int i = 0; i < protocolCount; i++) {
        
        Protocol *p = protocolList[i];
        addImplForProtocolWithBlock(c, p, s, block);
        
        va_list paramsList = NULL;
        va_start(paramsList, block);
        
        SEL nextSel = va_arg(paramsList, SEL);
        
        while (nextSel != NULL) {
            
            id nextBlock = va_arg(paramsList, id);
            addImplForProtocolWithBlock(c, p, nextSel, nextBlock);
            
            nextSel = va_arg(paramsList, SEL);
        }
        
        va_end(paramsList);
    }
    
    free(protocolList);
    
    return obj;
}


@end