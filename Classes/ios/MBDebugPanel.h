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

@end
