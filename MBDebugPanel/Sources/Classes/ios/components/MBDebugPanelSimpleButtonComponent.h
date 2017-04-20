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
