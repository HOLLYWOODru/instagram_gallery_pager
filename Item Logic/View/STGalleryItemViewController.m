//
//  STGalleryItemViewController.m
//  Sales Tool
//

#import "STGalleryItemViewController.h"
#import "PLDeviceChecker.h"

@interface STGalleryItemViewController()
{
    CGSize imageSize;
    float verticalOffset;
    float horizontalOffset;
    float deviceBorderOffset;
}

-(void)updateContainerSize;

@end

@implementation STGalleryItemViewController

#pragma mark - Init & Dealloc methods
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    if(self)
    {
        imageSize=CGSizeZero;
        
        if([PLDeviceChecker iPadDevice])
        {
            verticalOffset=80.0f;
            horizontalOffset=80.0f;
            deviceBorderOffset=10.0f;
        }
        else
        {
            verticalOffset=50.0f;
            horizontalOffset=20.0f;
            deviceBorderOffset=5.0f;
        }
    }
    
    return self;
}

-(void)dealloc
{
    //NSLog(@"%@ dealloced",self);
}

#pragma mark - UIViewController methods
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [loadingView setHidden:YES];
    [containerView setHidden:YES];
    
    [self.eventHandler viewDidLoad];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self updateContainerSize];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - IBAction methods
-(IBAction)userTappedOnBackground:(id)sender
{
    UITapGestureRecognizer *tapRecognizer=(UITapGestureRecognizer *)sender;
    
    CGPoint touchPoint=[tapRecognizer locationInView:self.view];
    
    if(!CGRectContainsPoint(containerView.frame,touchPoint))
    {
        [self.eventHandler userTappedOnBackground];
    }
}

#pragma mark - Public methods


#pragma mark - Private methods
-(void)updateContainerSize
{
    if(CGSizeEqualToSize(imageSize,CGSizeZero))
    {
        return;
    }
    
    float borderOffset=deviceBorderOffset;
    CGSize viewSize=self.view.frame.size;
    CGSize viewAreaSize=CGSizeMake(viewSize.width-2*(horizontalOffset+borderOffset),viewSize.height-2*(verticalOffset+borderOffset));
    
    CGFloat k1=viewAreaSize.width/imageSize.width;
    CGFloat k2=viewAreaSize.height/imageSize.height;
    CGFloat k=k1;
    
    if(k2<k1)
    {
        k=k2;
    }
    
    viewAreaSize=CGSizeMake(imageSize.width*k,imageSize.height*k);
    
    if(viewAreaSize.width>imageSize.width)
    {
        viewAreaSize=imageSize;
    }
    
    float minSide=MIN(viewAreaSize.width,viewAreaSize.height);
    
    borderOffset=MAX(MIN(deviceBorderOffset,minSide/30),2.0f);
    
    viewAreaSize=CGSizeMake(viewAreaSize.width+2*borderOffset,viewAreaSize.height+2*borderOffset);
    
    containerWidthConstraint.constant=viewAreaSize.width;
    containerHeightConstraint.constant=viewAreaSize.height;
    
    borderTopConstraint.constant=borderOffset;
    borderBottomConstraint.constant=borderOffset;
    borderLeftConstraint.constant=borderOffset;
    borderRightConstraint.constant=borderOffset;
    
    containerView.layer.cornerRadius=borderOffset/2;
    
    [self.view layoutIfNeeded];
}

#pragma mark - STGalleryItemViewInterface methods
-(NSInteger)getItemIndex
{
    return [self.eventHandler getCurrentItemIndex];
}

-(void)showPreloader
{
    [loadingView setHidden:NO];
}

-(void)hidePreloader
{
    [UIView animateWithDuration:0.15f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         loadingView.alpha=0.0f;
                     }
                     completion:^(BOOL completion){
                         loadingView.hidden=YES;
                     }];
    
}

-(void)showImage:(UIImage *)image
{
    // We must convert pixels to points: point = pixel/scale
    imageSize=CGSizeMake(image.size.width/[UIScreen mainScreen].scale,image.size.height/[UIScreen mainScreen].scale);
    
    [self updateContainerSize];
    
    [imageView setImage:image];
    [containerView setHidden:NO];
    containerView.alpha=0.0f;
    
    [UIView animateWithDuration:0.15f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         containerView.alpha=1.0f;
                     }
                     completion:^(BOOL completion){
                         [containerView setHidden:NO];
                         containerView.alpha=1.0f;
                     }];
}

@end
