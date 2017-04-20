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
//  MBDebugPanelSimpleComponent.m
//  
//
//  Created by Matthew Holden on 2/12/14.
//
//

#import "MBDebugPanel.h"
#import "MBDebugPanelSimpleComponent.h"
#import "MBDebugPanelSimpleButtonComponent.h"

@implementation MBDebugPanelSimpleComponent

-(CGFloat)cellHeight
{
    UITableViewCell *aCell = [self dummyCellInstance_];
    return [aCell bounds].size.height;
}

-(UITableViewCell*)cellForDisplayInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath*)indexPath
{
    NSString *cellClassName = [self cellClassName];
    [tableView registerNib:[self cellNib_] forCellReuseIdentifier:cellClassName];

    id cell = [tableView dequeueReusableCellWithIdentifier:cellClassName forIndexPath:indexPath];
    [self bindToReusableCell:cell];
    return cell;
}

-(UITableViewCell*)dummyCellInstance_
{
    NSAssert([NSThread isMainThread], @"This block assumes that all execution paths derive from the UI thread");

    static NSMutableDictionary *dummyCellsMap;
    UITableViewCell            *cell;
    NSString                   *thisClassName = NSStringFromClass(self.class);

    dummyCellsMap = dummyCellsMap ?: [NSMutableDictionary new];

    if (!(cell = dummyCellsMap[thisClassName])) {
            cell = [[self cellNib_] instantiateWithOwner:nil options:nil][0];
            dummyCellsMap[thisClassName] = cell;
    }

    return cell;
}

-(UINib*)cellNib_
{
    return [UINib nibWithNibName:[self cellClassName] bundle:[NSBundle bundleForClass:[MBDebugPanel class]]];
}

-(void)bindToReusableCell:(UITableViewCell*)cell
{
    [NSException raise:NSInternalInconsistencyException format:@"Abstract method -- must override"];
}

-(NSString*)cellClassName
{
    [NSException raise:NSInternalInconsistencyException format:@"Abstract method -- must override"];
    return nil;
}
@end
