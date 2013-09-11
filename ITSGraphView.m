//
//  ITSGraphView.m
//  ITS Framework Test App
//
//  Created by Martin Gustavsson on 2/14/13.
//  Copyright (c) 2013 Martin Gustavsson. All rights reserved.
//

#import "ITSGraphView.h"

@implementation ITSGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.dataloaded = FALSE;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super initWithCoder:decoder])) {
        [self drawRect:self.bounds];
        self.dataloaded = FALSE;
        self.graphdata = [[NSMutableArray alloc] init];
    }
    return self;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(void)addDatasetToGraph:(NSDictionary*)newgraphdata
{
    if (self.graphdata != nil)
    {
        [self.graphdata addObject:newgraphdata];
    }
    else
    {
        self.graphdata = [[NSMutableArray alloc] init];
        [self.graphdata addObject:newgraphdata];
    }
    [self setNeedsDisplay];
    //NSLog(@"added data: %@",self.graphdata);
    self.dataloaded = YES;
}

/*
-(NSDictionary*)locatePivotY:(NSNumber*)pivot forDataSet:(NSNumber*)dataset ascending:(BOOL)asc
{
    NSDictionary *compgraphdata = [[NSDictionary alloc] initWithDictionary:[self.graphdata objectAtIndex:[dataset intValue]]];
    NSArray *compydata = [compgraphdata objectForKey:@"ydata"];
    
    if (asc == YES)
    {
        for (int i = 0 ; i < [compydata count] ; i++)
        {
            if ([compydata objectAtIndex:i] <= pivot)
            {
                NSDictionary * returndict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:i],@"xval",[compydata objectAtIndex:i],@"yval",nil];
                return returndict;
                break;
            }
            break;
        }
    }
    if (asc == NO)
    {
        for (int i = [compydata count] ; i > 0 ; i--)
        {
            if ([compydata objectAtIndex:i] <= pivot)
            {
                NSDictionary * returndict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:i],@"xval",[compydata objectAtIndex:i],@"yval",nil];
                return returndict;
                break;
            }
            break;
        }
    }
    else
    {
        return nil;
    }
}
*/




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    
    //Init:
    [self setContentMode:UIViewContentModeRedraw];
    
    /*
     if (self.datasheet != nil)
     {
     int labelspace = 0;
     int border = 20;
     labelspace = ([self.datasheet count] * 21) + border;
     self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + labelspace);
     }
     */
    
    /*
    //OS Version:
    NSString *osver =[[UIDevice currentDevice] systemVersion];
    NSLog(@"OS Version: %i",osver.intValue);
    */
    
    //Graphimg:
    UIImageView *graphimageview = [[UIImageView alloc] initWithImage:nil];
    self.graphimg = graphimageview.image;
    graphimageview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    //Setup
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    //BG Color
    CGFloat colorval1[] = {1.0, 1.0, 1.0, 0.15};
    CGColorRef bgcolor = CGColorCreate(colorspace, colorval1);
    
    /*
     //Linecolor:
     CGColorRef linecolor;
     CGFloat colorval2[] = {1.0, 0.0, 0.0, 1.0};
     
     if (osver.intValue >= 7)
     {
     linecolor = self.tintColor.CGColor;
     }
     else
     {
     linecolor = CGColorCreate(colorspace, colorval2);
     }
     */
    
    //Clearcolor
    CGFloat colorval3[] = {0.0, 0.0, 0.0, 0.0};
    CGColorRef clearcolor = CGColorCreate(colorspace, colorval3);
    
#pragma mark variables
    //Variables
    
    NSArray *xlines = [[NSArray alloc] init];
    NSArray *ylines = [[NSArray alloc] init];
    NSArray *xdata = [[NSArray alloc] init];
    NSArray *ydata = [[NSArray alloc] init];
    NSArray *xlabels = [[NSArray alloc] init];
    NSArray *ylabels = [[NSArray alloc] init];
    NSNumber *logarithmicscalex;
    NSNumber *logarithmicscaley;
    NSNumber *datapointmarking;
    NSString *titlex = @"Frequency";
    NSString *titley;
    
    if (self.dataloaded == TRUE)
    {
        xlines = [[self.graphdata objectAtIndex:0] objectForKey:@"xlines"];
        ylines = [[self.graphdata objectAtIndex:0] objectForKey:@"ylines"];
        xlabels = [[self.graphdata objectAtIndex:0] objectForKey:@"xscale"];
        ylabels = [[self.graphdata objectAtIndex:0] objectForKey:@"yscale"];
        logarithmicscalex = [[self.graphdata objectAtIndex:0] objectForKey:@"xlog"];
        logarithmicscaley = [[self.graphdata objectAtIndex:0] objectForKey:@"ylog"];
        titlex = [[self.graphdata objectAtIndex:0] objectForKey:@"xtitle"];
        titley = [[self.graphdata objectAtIndex:0] objectForKey:@"ytitle"];
    }
    
    int graphx = 50;
    int graphy = 10;
    int graphwidth = self.frame.size.width - 60;
    int graphheight = self.frame.size.height - 50;
    int dotsize = 10;
    
    int numberoflinesx = [xlines count];
    int numberoflinesy = [ylines count];
    //int numberofxpoints = [xdata count];
    
    int graphmaxx = 1;
    int graphmaxy = 1;
    int graphminx = 0;
    int graphminy = 0;
    
    if (self.dataloaded == TRUE)
    {
        graphmaxx = [[xlines lastObject] intValue];
        graphmaxy = [[ylines lastObject] intValue];
        graphminx = [[xlines objectAtIndex:0] intValue];
        graphminy = [[ylines objectAtIndex:0] intValue];
    }
    
    int graphintervalx = graphmaxx-graphminx;
    int graphintervaly = graphmaxy-graphminy;
    
    float adapter1 = (double)graphwidth / log((double)graphintervalx);
    float adapter2 = (double)graphwidth / (double)graphintervalx;
    float adapter3 = (double)graphheight / log((double)graphintervaly);
    float adapter4 = (double)graphheight / (double)graphintervaly;
    
    int xoffset = graphminx;
    int yoffset = graphminy;
    
#pragma mark frame drawing
    // Drawing code #
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Frame #
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGRect rectangle = CGRectMake(graphx, graphy, graphwidth, graphheight);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, bgcolor);
    CGContextFillRect(context, rectangle);
    
#pragma mark titles
    if (self.dataloaded == TRUE)
    {
        CGContextSelectFont(context, "Helvetica", 17, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(context, kCGTextFill);
        CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
        
        //title X #
        //CGSize titlexsize = [titlex sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17]];
        CGSize titlexsize = [titlex sizeWithFont:[UIFont systemFontOfSize:17]];
        int xtitlexpos = graphx + (graphwidth/2) - (titlexsize.width / 2);
        int xtitleypos = self.frame.size.height - 5;
        
        CGContextSetTextMatrix (context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
        CGContextShowTextAtPoint(context, xtitlexpos, xtitleypos, [titlex cStringUsingEncoding:NSUTF8StringEncoding], [titlex length]);
        
        //title Y #
        CGSize titleysize = [titley sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17]];
        int ytitleypos = graphy + (graphheight / 2) - (titleysize.width / 2);
        int ytitlexpos = 5;
        
        CGContextSetTextMatrix(context, CGAffineTransformRotate(CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0), -M_PI / 2));
        CGContextShowTextAtPoint(context, ytitlexpos, ytitleypos, [titley cStringUsingEncoding:NSUTF8StringEncoding], [titley length]);
    }
    
#pragma mark scale x
    if (self.dataloaded == TRUE)
    {
        for (int i=0,j=0; i<numberoflinesx; i++) {
            
            int xpoint = [[xlines objectAtIndex:i] intValue];
            float xgrid;
            int xsc;
            
            if ([logarithmicscalex boolValue] == TRUE){
                xgrid = log((xpoint+1) - graphminx) * adapter1;
            }
            
            if ([logarithmicscalex boolValue] == FALSE){
                xgrid = (xpoint - graphminx) * adapter2;
            }
            
            int xlj = [[xlabels objectAtIndex:j] intValue];
            
            if (i == xlj)
            {
                xsc = [[xlines objectAtIndex:i] intValue];
                NSString *xn = [NSString stringWithFormat:@"%.i",xsc];
                CGSize xnsize = [xn sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17]];
                //CGContextSelectFont(context, "Helvetica", 17, kCGEncodingMacRoman);
                CGContextSetTextDrawingMode(context, kCGTextFill);
                CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
                CGContextSetTextMatrix (context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
                CGContextShowTextAtPoint(context, graphx + xgrid - (xnsize.width/2), graphheight + 5 + xnsize.height, [xn cStringUsingEncoding:NSUTF8StringEncoding], [xn length]);
                
                if (xlj < [[xlabels lastObject] intValue])
                {
                    j++;
                }
            }
            
            if ([[xlines objectAtIndex:i] intValue] == 0){
                CGContextSetLineWidth(context, 2.0);
            }
            else{
                CGContextSetLineWidth(context, 1.0);
            }
            
            CGContextMoveToPoint(context, graphx + xgrid, graphy);
            CGContextAddLineToPoint(context, graphx + xgrid, graphy + graphheight);
            CGContextStrokePath(context);
            
        }
    }
    
#pragma mark scale y
    if (self.dataloaded == TRUE)
    {
        for (int i=0,j=0; i<numberoflinesy; i++) {
            
            int ypoint = [[ylines objectAtIndex:i] intValue];
            float ygrid;
            int ysc;
            
            if ([logarithmicscaley boolValue] == TRUE){
                ygrid = log((ypoint+1) - graphminy) * adapter3;
            }
            
            if ([logarithmicscaley boolValue] == FALSE){
                ygrid = (ypoint - graphminy) * adapter4;
            }
            
            int ylj = [[ylabels objectAtIndex:j] intValue];
            
            if (i == ylj)
            {
                ysc = [[ylines objectAtIndex:i] intValue];
                NSString *yn = [NSString stringWithFormat:@"%.i",ysc];
                CGSize ynsize = [yn sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17]];
                //CGContextSelectFont(context, "Helvetica", 17, kCGEncodingMacRoman);
                CGContextSetTextDrawingMode(context, kCGTextFill);
                CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
                CGContextSetTextMatrix (context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
                CGContextShowTextAtPoint(context, graphx - ynsize.width - 4, graphy + graphheight - ygrid + (ynsize.height/4), [yn cStringUsingEncoding:NSUTF8StringEncoding], [yn length]);
                
                if (ylj < [[ylabels lastObject] intValue])
                {
                    j++;
                }
            }
            
            if ([[ylines objectAtIndex:i] intValue] == 0){
                CGContextSetLineWidth(context, 2.0);
            }
            else{
                CGContextSetLineWidth(context, 1.0);
            }
            
            CGContextMoveToPoint(context, graphx , graphy + graphheight - ygrid);
            CGContextAddLineToPoint(context, graphx + graphwidth, graphy +graphheight - ygrid);
            CGContextStrokePath(context);
            
        }
    }
    
#pragma mark error msg
    if (self.dataloaded == TRUE)
    {
        /*
         if (numberofypoints != numberofxpoints)
         {
         overlaytext = @"Error 002 , the number of x-values does not match the number of y-values.";
         }
         
         else if (xdata == nil || ydata == nil)
         {
         overlaytext = @"Error 003 , No graph data.";
         
         }
         else if ([xdata count] < 2 && [ydata count] < 2)
         {
         overlaytext = @"Error 004 , only one value in array.";
         }
         */
    }
    
#pragma mark graph drawing
    if (self.dataloaded == TRUE)
    {
        for (int i=0; i < ([self.graphdata count]); i++)
        {
            
            int graphnumber = i;
            xdata = [[self.graphdata objectAtIndex:i] objectForKey:@"xdata"];
            ydata = [[self.graphdata objectAtIndex:i] objectForKey:@"ydata"];
            datapointmarking = [[self.graphdata objectAtIndex:i] objectForKey:@"datamarking"];
            int numberofxpoints = [xdata count];
            
            for (int i=0; i<numberofxpoints; i++) {
                float xval;
                float yval;
                float prevx;
                float prevy;
                
                CGContextSetLineWidth(context, 1.0);
                
                if ([logarithmicscalex boolValue] == TRUE)
                {
                    
                    float xpiv = [[xdata objectAtIndex:i] intValue];
                    
                    if (xpiv < graphminx)
                    {
                        xpiv = graphminx;
                    }
                    if (xpiv > graphmaxx)
                    {
                        xpiv = graphmaxx;
                    }
                    xval = log(xpiv - xoffset) * adapter1;
                }
                
                if ([logarithmicscalex boolValue] == FALSE)
                {
                    float xpiv = [[xdata objectAtIndex:i] intValue];
                    
                    if (xpiv < graphminx)
                    {
                        xpiv = graphminx;
                    }
                    if (xpiv > graphmaxx)
                    {
                        xpiv = graphmaxx;
                    }
                    xval = (xpiv - xoffset) * adapter2;
                }
                
                if ([logarithmicscaley boolValue] == FALSE)
                {
                    float ypiv = [[ydata objectAtIndex:i] intValue];
                    
                    if (ypiv < graphminy)
                    {
                        ypiv = graphminy;
                    }
                    if (ypiv > graphmaxy)
                    {
                        ypiv = graphmaxy;
                    }
                    yval = (ypiv - yoffset) * adapter4;
                }
                
                if ([logarithmicscaley boolValue] == TRUE)
                {
                    float ypiv = [[ydata objectAtIndex:i] intValue];
                    
                    if (ypiv < graphminy)
                    {
                        ypiv = graphminy;
                    }
                    if (ypiv > graphmaxy)
                    {
                        ypiv = graphmaxy;
                    }
                    yval = log(ypiv - yoffset) * adapter3;
                }
                
                if (numberofxpoints > 1 && i > 0) {
                    
                    
                    if ([logarithmicscalex boolValue] == TRUE)
                    {
                        
                        float xpiv = [[xdata objectAtIndex:i-1] intValue];
                        if (xpiv < graphminx)
                        {
                            xpiv = graphminx;
                        }
                        if (xpiv > graphmaxx)
                        {
                            xpiv = graphmaxx;
                        }
                        prevx = log(xpiv - xoffset) * adapter1;
                    }
                    
                    if ([logarithmicscalex boolValue] == FALSE)
                    {
                        float xpiv = [[xdata objectAtIndex:i-1] intValue];
                        if (xpiv < graphminx)
                        {
                            xpiv = graphminx;
                        }
                        if (xpiv > graphmaxx)
                        {
                            xpiv = graphmaxx;
                        }
                        prevx = (xpiv - xoffset) * adapter2;
                    }
                    
                    if ([logarithmicscaley boolValue] == FALSE)
                    {
                        float ypiv = [[ydata objectAtIndex:i-1] intValue];
                        if (ypiv < graphminy)
                        {
                            ypiv = graphminy;
                        }
                        if (ypiv > graphmaxy)
                        {
                            ypiv = graphmaxy;
                        }
                        prevy = (ypiv - yoffset) * adapter4;
                    }
                    
                    if ([logarithmicscaley boolValue] == TRUE)
                    {
                        float ypiv = [[ydata objectAtIndex:i-1] intValue];
                        if (ypiv < graphminy)
                        {
                            ypiv = graphminy;
                        }
                        if (ypiv > graphmaxy)
                        {
                            ypiv = graphmaxy;
                        }
                        prevy = log(ypiv - yoffset) * adapter3;
                    }
                    
                    
                    //Set graph color:
                    
                    UIColor * graphcolor = [[self.graphdata objectAtIndex:graphnumber] objectForKey:@"color"];
                    CGColorRef gc = graphcolor.CGColor;
                    CGContextSetStrokeColorWithColor(context,gc);
                    
                    if ((xval == 0 || yval == 0) && ((prevx == 0 || prevy == 0)))
                    {
                        CGContextSetStrokeColorWithColor(context,clearcolor);
                    }
                    
                    //Draw Data Marks
                    if ([datapointmarking boolValue] == TRUE)
                    {
                        CGRect graphcircle = CGRectMake(graphx + xval - (dotsize/2), graphy + graphheight - yval - (dotsize/2),dotsize,dotsize);
                        CGContextAddEllipseInRect(context, graphcircle);
                        CGContextStrokePath(context);
                    }
                    
                    //Draw Graph line
                    CGContextSetLineWidth(context, 2.0);
                    CGContextMoveToPoint(context, graphx + prevx, graphy + graphheight - prevy);
                    CGContextAddLineToPoint(context, graphx + xval, graphy + graphheight - yval);
                    CGContextStrokePath(context);
                }
                
            }
        }
    }
    
#pragma mark text overlay
    //OverlayText
    if (self.overlaytext != nil)
    {
        CGSize tsize = [self.overlaytext sizeWithFont:[UIFont fontWithName:@"Helvetica" size:21]];
        CGContextSelectFont(context, "Helvetica", 21, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(context, kCGTextFill);
        CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextSetTextMatrix (context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
        CGContextShowTextAtPoint(context, graphx + (graphwidth/2) - (tsize.width/2), graphy + (graphheight/2) + (tsize.height/4), [self.overlaytext cStringUsingEncoding:NSUTF8StringEncoding], [self.overlaytext length]);
    }
    
#pragma mark graphimage property generation
    //[self generateGraphImage];
    
}

-(void)generateGraphImage
{}

@end
