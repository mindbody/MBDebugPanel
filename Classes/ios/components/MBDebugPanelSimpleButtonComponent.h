//
//  MBDebugPanelSimpleButtonComponent.h
//  MBDebugPanel
//
//  Created by Matthew Holden on 2/11/14.
//
//

#import "MBDebugPanelSimpleComponent.h"

@interface MBDebugPanelSimpleButtonComponent : MBDebugPanelSimpleComponent <MBDebugPanelComponent>
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *buttonTitle;
@property (nonatomic, copy, readonly) void(^onButtonPressed)(void);

/** Create a new button component
 @param title The main text to display next to the button.
 @param buttonTitle The text to display in the UIButton
 @param onButtonPressed A callback block to invoke when the button is tapped
 */
-(id)initWithTitle:(NSString*)title buttonTitle:(NSString*)buttonTitle onButtonPressed:(void(^)(void))onButtonPressed;
@end
