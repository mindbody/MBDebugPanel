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
    return [UINib nibWithNibName:[self cellClassName] bundle:nil];
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
