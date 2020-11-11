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
//  MBDebugPanelComponent.h
//  MBDebugPanel
//
//  Created by Matthew Holden on 2/10/14.
//
//

#import <UIKit/UIKit.h>

/**
 Custom components need only implement the two methods provided by this protocol. 
 MBDebugPanel attempts to be efficent by letting you leverage the UITableView cell reuse queue.
 If you plan to define a component and use multiple instances of it, you can leverage cell reuse offered by the UITableView methods "registerNib:forCellReuseIdentifier" and "dequeueReusableCellWithIdentifier:forIndexPath:"
 */

@protocol MBDebugPanelComponent <NSObject>
@required

/**
 To properly provide the panel's UITableView measurements for row height, all components must
 return the height of their cells.  You are free to implement this property however you like. It is called when the table view invokes `tableView:heightForRowAtIndexPath` on its data source.
 */
-(CGFloat)cellHeight;

/**
 Provide a UITableViewCell (or subclass) to display in the panel.
 @param tableView The UITableView the panel will show your component in.
 @param indexPath the index path in `tableView` this cell will represent
 @notes You may reliably use the `tableView` and `indexPath` parameters to attempt to dequeue a reusable table cell from `tableView`'s reuse queue.
 */
-(UITableViewCell*)cellForDisplayInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;
@end
