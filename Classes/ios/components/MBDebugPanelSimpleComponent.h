//
//  MBDebugPanelSimpleComponent.h
//  
//
//  Created by Matthew Holden on 2/12/14.
//
//

#import <Foundation/Foundation.h>
#import "MBDebugPanelComponent.h"

/** 
 An abstract base class for implementing "Simple" components
 
 @notes If you choose to use this base class to quickly develop a new component, your subclass MUST override `cellClassName` and `bindToReusableCell:`
 
 Additional requirements: 
 * A .xib should be in your default bundle to represent the table cell this component will return.
 * That UITableViewCell .xib should have the same file name as the string returned by `cellClassName`
 
 Ideally: 
 * You should register this .xib with the table view inside `cellForDisplayInTableView:atIndexPath:`, and attempt to dequeue reusable instances with -[UITableView dequeueReusableCellWithIdentifier:forIndexpath:]

 @see MBDebugPanelSimpleButtonComponent and MBDebugPanelSimpleSwitchComponent for implementation examples
 */
@interface MBDebugPanelSimpleComponent : NSObject <MBDebugPanelComponent>
@end
