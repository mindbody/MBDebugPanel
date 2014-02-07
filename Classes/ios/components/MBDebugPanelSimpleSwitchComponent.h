//
//  MBDebugPanelSimpleSwitchComponent.h
//  MBDebugPanel
//
//  Created by Matthew Holden on 2/11/14.
//
//

#import "MBDebugPanelSimpleComponent.h"
#import <Foundation/Foundation.h>

@interface MBDebugPanelSimpleSwitchComponent : MBDebugPanelSimpleComponent <MBDebugPanelComponent>

@property (nonatomic, copy, readonly)       NSString *title;
@property (nonatomic, copy, readonly) void(^onSwitchChanged)(BOOL newValue);

/** Create a new UISwitch component
 @param title The main text to display next to the switch
 @param changeHandler A callback block to invoke when the switch value changes
 */
-(id)initWithTitle:(NSString*)title onSwitchChanged:(void(^)(BOOL))changeHandler;
@end
