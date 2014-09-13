//
//  NPKeyboardLayoutGuideTests.m
//  NPKeyboardLayoutGuideTests
//
//  Created by Oleksii Kuchma on 09/13/2014.
//  Copyright (c) 2014 Oleksii Kuchma. All rights reserved.
//

#import "NPKeyboardLayoutGuide.h"

#import <UIKit/UIKit.h>

SpecBegin(InitialSpecs)

describe(@"Creation of layout guide", ^{
    
    it (@"lazily", ^{
        UIViewController *vc = [[UIViewController alloc] init];
        
        id layoutGuide = vc.keyboardLayoutGuide;
        
        expect(layoutGuide).toNot.equal(nil);
    });
    
    it (@"repeatedly", ^{
        UIViewController *vc = [[UIViewController alloc] init];
        
        id layoutGuide = vc.keyboardLayoutGuide;
        id nextLayoutGuide = vc.keyboardLayoutGuide;
        
        expect(layoutGuide).to.equal(nextLayoutGuide);
    });
});

SpecEnd
