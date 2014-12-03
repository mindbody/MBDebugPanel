//
//  MBDebugPanelSimpleTextFieldComponent.h
//  MBDebugPanel
//
//  Created by Ian on 12/3/14.
//
//

#import "MBDebugPanelSimpleComponent.h"

@interface MBDebugPanelSimpleTextFieldComponent : MBDebugPanelSimpleComponent <MBDebugPanelComponent, UITextFieldDelegate>
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *placeholderText;
@property (nonatomic, copy, readonly) NSString *(^initialText)();
@property (nonatomic, copy, readonly) void(^onEditingDidEnd)(NSString *text);

/** Create a new text field component
 @param title The main text to display next to the text field
 @param placeholderText The placeholder text to display in the text field
 @param initialText A callback block to invoke when the cell is recreated and needs an initial text value
 @param onEditingDidEnd A callback block to invoke when editing the text field ends
 */
-(id)initWithTitle:(NSString *)title placeholderText:(NSString *)placeholderText initialText:(NSString *(^)(void))initialText onEditingDidEnd:(void(^)(NSString *text))onEditingDidEnd;
@end
