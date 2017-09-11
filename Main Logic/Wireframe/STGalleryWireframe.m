//
//  STGalleryWireframe.m
//  Sales Tool
//

#import "STGalleryViewController.h"
#import "STGalleryWireframe.h"
#import "STGalleryPresenter.h"
#import "PLSettings.h"

static NSString *STGalleryControllerIdentifier = @"GalleryViewController";

@interface STGalleryWireframe()
{
    
}

@property (nonatomic,strong) STGalleryViewController *viewController;

-(STGalleryViewController *)galleryViewController;
-(UIStoryboard *)galleryStoryboard;

@end

@implementation STGalleryWireframe

#pragma mark - Init method
-(id)init
{
    self=[super init];
    
    if(self)
    {
        
    }
    
    return self;
}

-(void)dealloc
{
    //NSLog(@"%@ dealloced",self);
}

#pragma mark - Public methods
-(void)presentGalleryInView:(UIView *)view
{
    STGalleryViewController *galleryViewController=[self galleryViewController];
    
    galleryViewController.eventHandler=self.presenter;
    
    self.presenter.userInterface=galleryViewController;
    
    [galleryViewController.view setFrame:view.bounds];
    [galleryViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    [view addSubview:galleryViewController.view];
    
    [galleryViewController.view setNeedsDisplay];
    [view setNeedsDisplay];
    
    self.viewController=galleryViewController;
    
    view.hidden=NO;
    view.alpha=1.0f;
    
    [galleryViewController animateContentView];
}

-(void)hideGallery:(BOOL)animated
{
    UIView *view=[self.viewController.view superview];
    
    if(animated)
    {
        [UIView animateWithDuration:0.2f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             view.alpha=0.0f;
                         }
                         completion:^(BOOL completion){
                             view.hidden=YES;
                             
                             [self.presenter clean];
                             
                             [self.viewController.view removeFromSuperview];
                             self.viewController=nil;
                         }];
    }
    else
    {
        view.alpha=0.0f;
        view.hidden=YES;
        
        [self.presenter clean];
        
        [self.viewController.view removeFromSuperview];
        self.viewController=nil;
    }
}

#pragma mark - Private methods
-(STGalleryViewController *)galleryViewController
{
    UIStoryboard *storyboard=[self galleryStoryboard];
    STGalleryViewController *viewController=[storyboard instantiateViewControllerWithIdentifier:STGalleryControllerIdentifier];
    
    return viewController;
}

-(UIStoryboard *)galleryStoryboard
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Gallery" bundle:[NSBundle mainBundle]];
    
    return storyboard;
}

@end
