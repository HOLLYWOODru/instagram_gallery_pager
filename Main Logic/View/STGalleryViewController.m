//
//  STGalleryController.m
//  Sales Tool
//

#import "STGalleryViewController.h"
#import "PLDeviceChecker.h"
#import "UIImage+Tint.h"
#import "PLFunctions.h"
#import "PLSettings.h"

@interface STGalleryViewController()<STPageControlDelegate>
{
    
}

-(void)addBlurView;

@property (nonatomic,retain) UIPageViewController *pageViewController;

@end

@implementation STGalleryViewController

@synthesize pageViewController;

#pragma mark - Init & Dealloc methods
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    if(self)
    {
        
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
    
    contentView.alpha=0.0f;
    
    pageControl.delegate=self;
    pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor=[PLFunctions colorWithHexString:@"00b4ff"];
    
    [self addBlurView];
    
    [self.eventHandler viewDidLoad];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - IBAction methods
-(IBAction)closeClicked:(id)sender
{
    [self.eventHandler mustCloseGallery];
}

#pragma mark - Public methods
-(void)animateContentView
{
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         contentView.alpha=1.0f;
                     }
                     completion:^(BOOL completion){
                         contentView.alpha=1.0f;
                     }];
}

#pragma mark - Private methods
-(void)addBlurView
{
    if(!UIAccessibilityIsReduceTransparencyEnabled())
    {
        self.view.backgroundColor=[UIColor clearColor];
        
        UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView=[[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame=controlView.bounds;
        blurEffectView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        
        [controlView addSubview:blurEffectView];
    }
    else
    {
        self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.65f];
        
        topViewHeightConstraint.constant=68.0f;
        bottomViewHeightConstraint.constant=48.0f;
        
        [self.view setNeedsDisplay];
    }
}

#pragma mark - STGalleryViewInterface methods
-(void)addPageViewController:(UIPageViewController *)_pageViewController
{
    self.pageViewController=_pageViewController;
    
    pageViewController.view.frame=contentView.bounds;
    
    [self addChildViewController:pageViewController];
    [contentView addSubview:pageViewController.view];
    
    [pageViewController didMoveToParentViewController:self];
}

-(void)showItemViewController:(UIViewController *)itemViewController direction:(UIPageViewControllerNavigationDirection)direction animated:(BOOL)animated
{
    if(itemViewController)
    {
        NSArray *viewControllers=@[itemViewController];
        
        [self.pageViewController setViewControllers:viewControllers direction:direction animated:animated completion:nil];
    }
}

-(void)setTotalPagesCount:(NSInteger)totalPagesCount withCurrentPageIndex:(NSInteger)index;
{
    [pageControl setNumberOfPages:totalPagesCount withCurrentPage:index];
}

-(void)setCurrentPageIndex:(NSInteger)index
{
    [pageControl setCurrentPage:index];
}

-(UIPageViewController *)getPageViewController
{
    return pageViewController;
}

#pragma mark - STPageControlDelegate methods
-(void)indexChanged:(NSInteger)index forPageControl:(STPageControl *)_pageControl
{
    if(pageControl==_pageControl)
    {
        [self.eventHandler pageHasBeenChanged:index];
    }
}

@end
