//
//  MBDebugPanelComponent.h
//  MBDebugPanel
//
//  Created by Matthew Holden on 2/10/14.
//
//

#import <Foundation/Foundation.h>

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
