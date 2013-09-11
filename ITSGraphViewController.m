//
//  ITSGraphViewController.m
//  ITSKit
//
//  Created by Martin Gustavsson on 9/9/13.
//  Copyright (c) 2013 Martin Gustavsson. All rights reserved.
//

#import "ITSGraphViewController.h"

@interface ITSGraphViewController ()

@end

@implementation ITSGraphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initGraphData
{
    int cxlines[]={0,10,20,30,40,50,60,70,80,90,100,200,300,400,500,600,700,800,900,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,20000,30000};
    int cylines[]={-40,-30,-20,-10,0,10,20};
    
    int xsize = sizeof cxlines /sizeof(int);
    int ysize = sizeof cylines /sizeof(int);
    
    int cxlabels[]={0,1,10,19,28};
    int cylabels[]={0,1,2,3,4,5,6};
    
    int xsize2 = sizeof cxlabels /sizeof(int);
    int ysize2 = sizeof cylabels /sizeof(int);
    
    //int bottomfreq = cxlines[0];
    
    NSMutableArray * pxdata = [[NSMutableArray alloc] init];
    NSMutableArray * pydata = [[NSMutableArray alloc] init];
    NSMutableArray * pxdata2 = [[NSMutableArray alloc] init];
    NSMutableArray * pydata2 = [[NSMutableArray alloc] init];
    
    NSMutableArray * pxlabels = [[NSMutableArray alloc] init];
    NSMutableArray * pylabels = [[NSMutableArray alloc] init];
    NSMutableArray * pxlines = [[NSMutableArray alloc] init];
    NSMutableArray * pylines = [[NSMutableArray alloc] init];
    
    for (int i=0; i<xsize ; i++)
    {
        [pxlines addObject:[NSNumber numberWithFloat:cxlines[i]]];
    }
    
    for (int i=0; i<ysize ; i++)
    {
        [pylines addObject:[NSNumber numberWithFloat:cylines[i]]];
    }
    
    for (int i=0; i<xsize2 ; i++)
    {
        [pxlabels addObject:[NSNumber numberWithFloat:cxlabels[i]]];
    }
    
    for (int i=0; i<ysize2 ; i++)
    {
        [pylabels addObject:[NSNumber numberWithFloat:cylabels[i]]];
    }
    
    [pxdata addObject:[NSNumber numberWithFloat:10]];
    [pxdata addObject:[NSNumber numberWithFloat:20]];
    [pxdata addObject:[NSNumber numberWithFloat:30]];
    [pxdata addObject:[NSNumber numberWithFloat:40]];
    [pxdata addObject:[NSNumber numberWithFloat:50]];
    [pxdata addObject:[NSNumber numberWithFloat:60]];
    [pxdata addObject:[NSNumber numberWithFloat:70]];
    [pxdata addObject:[NSNumber numberWithFloat:100]];
    [pxdata addObject:[NSNumber numberWithFloat:120]];
    [pxdata addObject:[NSNumber numberWithFloat:150]];
    [pxdata addObject:[NSNumber numberWithFloat:250]];
    [pxdata addObject:[NSNumber numberWithFloat:350]];
    [pxdata addObject:[NSNumber numberWithFloat:30000]];
    
    [pydata addObject:[NSNumber numberWithFloat:-60]];
    [pydata addObject:[NSNumber numberWithFloat:-50]];
    [pydata addObject:[NSNumber numberWithFloat:-45]];
    [pydata addObject:[NSNumber numberWithFloat:-30]];
    [pydata addObject:[NSNumber numberWithFloat:-25]];
    [pydata addObject:[NSNumber numberWithFloat:-19]];
    [pydata addObject:[NSNumber numberWithFloat:-15]];
    [pydata addObject:[NSNumber numberWithFloat:-10]];
    [pydata addObject:[NSNumber numberWithFloat:-8]];
    [pydata addObject:[NSNumber numberWithFloat:-5]];
    [pydata addObject:[NSNumber numberWithFloat:-1]];
    [pydata addObject:[NSNumber numberWithFloat:0]];
    [pydata addObject:[NSNumber numberWithFloat:0]];
    
    
    
    
    
    [pxdata2 addObject:[NSNumber numberWithFloat:10]];
    [pxdata2 addObject:[NSNumber numberWithFloat:50]];
    [pxdata2 addObject:[NSNumber numberWithFloat:100]];
    [pxdata2 addObject:[NSNumber numberWithFloat:500]];
    
    [pydata2 addObject:[NSNumber numberWithFloat:-20]];
    [pydata2 addObject:[NSNumber numberWithFloat:-15]];
    [pydata2 addObject:[NSNumber numberWithFloat:0]];
    [pydata2 addObject:[NSNumber numberWithFloat:5]];
    
    NSString * xtitle = @"Frequency";
    NSString * ytitle = @"dB";
    
    
    self.graphdata = [[NSDictionary alloc] initWithObjectsAndKeys:
                 [NSNumber numberWithInt:1],@"graph",
                 [NSNumber numberWithBool:YES],@"xlog",
                 [NSNumber numberWithBool:NO],@"ylog",
                 [NSNumber numberWithBool:NO],@"datamarking",
                 xtitle,@"xtitle",
                 ytitle,@"ytitle",
                 pxlines,@"xlines",
                 pylines,@"ylines",
                 pxlabels,@"xscale",
                 pylabels,@"yscale",
                 self.view.tintColor,@"color",
                 pxdata,@"xdata",
                 pydata,@"ydata",
                      nil];
    
    self.graphdata2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                      [NSNumber numberWithInt:1],@"graph",
                      [NSNumber numberWithBool:YES],@"xlog",
                      [NSNumber numberWithBool:NO],@"ylog",
                      [NSNumber numberWithBool:YES],@"datamarking",
                      xtitle,@"xtitle",
                      ytitle,@"ytitle",
                      pxlines,@"xlines",
                      pylines,@"ylines",
                      pxlabels,@"xscale",
                      pylabels,@"yscale",
                      [UIColor greenColor],@"color",
                      pxdata2,@"xdata",
                      pydata2,@"ydata",
                      nil];
    
    [graph addDatasetToGraph:self.graphdata];
    [graph addDatasetToGraph:self.graphdata2];
    
}

- (void)viewDidLoad
{
    [self initGraphData];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)sharebuttonpressed
{
    self.sharedcontent = [[NSMutableArray alloc] init];
    if (graph.graphimg != nil)
    {
        [self.sharedcontent addObject:graph.graphimg];
        [self.sharedcontent addObject:@"Test"];
    }
    [self shareContent:self.sharedcontent];
}

-(void)shareContent:(NSMutableArray*)content;
{
    if (content != nil)
    {
        UIActivityViewController* avc = [[UIActivityViewController alloc] initWithActivityItems:content applicationActivities:nil];
        NSLog(@"Content: %@",content);
        [self.navigationController presentViewController:avc animated:YES completion:nil];
    }
    
    else
    {
        NSLog(@"No content");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
