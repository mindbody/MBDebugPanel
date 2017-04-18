//Copyright (c) 2014 MINDBODY, Inc. <www.mindbodyonline.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//
//
//  MBDebugPanel.h
//  MBDebugPanel
//
//  Created by Matthew Holden on 2/6/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Expose common public headers via MBDebugPanel.h,
// so end-users only have to import <MBDebugPanel/MBDebugPanel.h>
#import "MBDebugPanelComponent.h"
#import "MBDebugPanelSimpleComponent.h"
#import "MBDebugPanelSimpleButtonComponent.h"
#import "MBDebugPanelSimpleSwitchComponent.h"
#import "MBDebugPanelSimpleTextFieldComponent.h"

@interface MBDebugPanel : UITableViewController <UITableViewDataSource, UITableViewDelegate>

/** Add a component to the panel */
+(void)addComponent:(id<MBDebugPanelComponent>)component;

/** 
 Add multiple components.
 @param components An array of components to add to the panel
 */
+(void)addComponentsFromArray:(NSArray*)components;

/** Remove a component. */
+(void)removeComponent:(id<MBDebugPanelComponent>)component;

/** 
 Remove multiple components.
 @param components An array of components to attempt to remove from the panel
 */
+(void)removeComponentsInArray:(NSArray*)components;

/** Remove all components */
+(void)removeAllComponents;

/** Show the panel */
+(void)show;

/** Hide the panel */
+(void)hide;

/** 
 Invoke "reloadData" on the panel's UITableView
 @notes Call this method if you have added or removed
 components while the panel is visible.
 */
+(void)reloadComponents;

/** 
 Whether or not the panel is currently shown
 @notes Manipulation of the app window's rootViewController
 could cause this to return YES unexpectedly.  This method returns
 true if the panel is presented inside a parent navigation controller.
 However, this does not make a guarantee that the parent is still at the top of the view hierarchy.
 */
+(BOOL)isPresented;

/*
 Present a view controller from the DebugPanel's parent viewcontroller
 */
+ (void)presentViewController:(UIViewController *)viewControllerToPresent
                     animated:(BOOL)flag
                   completion:(void (^ __nullable)(void))completion;
@end
