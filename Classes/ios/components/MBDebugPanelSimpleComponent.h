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
