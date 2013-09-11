//
//  ITSGraphView.h
//  ITS Framework Test App
//
//  Created by Martin Gustavsson on 2/14/13.
//  Copyright (c) 2013 Martin Gustavsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITSGraphView : UIView

@property (nonatomic, strong) NSMutableArray * graphdata;
@property (nonatomic, retain) NSString *overlaytext;

@property (nonatomic, retain) UIImage *graphimg;
//@property (nonatomic, retain) NSMutableArray *datasheet;

@property (nonatomic)bool dataloaded;

-(void)addDatasetToGraph:(NSDictionary*)newgraphdata;
//-(NSDictionary*)locatePivotY:(NSNumber*)pivot forDataSet:(NSNumber*)dataset ascending:(BOOL)asc;

@end
