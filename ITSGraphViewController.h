//
//  ITSGraphViewController.h
//  ITSKit
//
//  Created by Martin Gustavsson on 9/9/13.
//  Copyright (c) 2013 Martin Gustavsson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITSGraphView.h"

@interface ITSGraphViewController : UIViewController
{
    IBOutlet ITSGraphView* graph;
}

@property (nonatomic,retain)NSMutableArray* sharedcontent;
@property (nonatomic,retain)NSDictionary* graphdata;
@property (nonatomic,retain)NSDictionary* graphdata2;


-(IBAction)sharebuttonpressed;
@end
