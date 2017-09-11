//
//  STGalleryPresenter.m
//  Sales Tool
//

#import "STGalleryItemViewController.h"
#import "STGalleryItemPresenter.h"
#import "STGalleryItemInteractor.h"

#import "STGalleryInteractor.h"
#import "STGalleryPresenter.h"

static NSString *STGalleryPageControllerIdentifier = @"GalleryPageViewController";
static NSString *STGalleryItemControllerIdentifier = @"GalleryItemViewController";

@interface STGalleryPresenter()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,STGalleryItemPresenterDelegate>
{
    NSInteger currentPageIndex;
    int autoSlidesCount;
}

@property (nonatomic,retain) NSArray *items;

-(UIStoryboard *)galleryStoryboard;
-(UIPageViewController *)pageViewController;
-(UIViewController *)viewControllerAtIndex:(NSInteger)index;
-(void)showPageWithIndex:(NSInteger)index;
-(void)updateCurrentPageForPageViewController:(UIPageViewController *)pageViewController;
-(STGalleryItemViewController *)itemViewControllerForItem:(id<STGalleryItemProtocol>)item withIndex:(NSInteger)index;

@end

@implementation STGalleryPresenter

@synthesize items;

#pragma mark - Init method
-(id)init
{
    self=[super init];
    
    if(self)
    {
        currentPageIndex=0;
        autoSlidesCount=0;
    }
    
    return self;
}

-(void)dealloc
{
    //NSLog(@"%@ dealloced",self);
}

#pragma mark - Public methods
-(void)setInteractor:(id<STGalleryInteractorInput>)interactor
{
    _interactor=interactor;
    
    self.items=[self.interactor getItems];
}

#pragma mark - Private methods
-(UIStoryboard *)galleryStoryboard
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Gallery" bundle:[NSBundle mainBundle]];
    
    return storyboard;
}

-(UIPageViewController *)pageViewController
{
    UIStoryboard *storyboard=[self galleryStoryboard];
    UIPageViewController *pageViewController=[storyboard instantiateViewControllerWithIdentifier:STGalleryPageControllerIdentifier];
    
    return pageViewController;
}

-(UIViewController *)viewControllerAtIndex:(NSInteger)index
{
    if((index<0)||(index>=items.count))
    {
        return nil;
    }
    
    id<STGalleryItemProtocol> item=[self.items objectAtIndex:index];
    UIViewController *galleryItemViewController=[self itemViewControllerForItem:item withIndex:index];
    
    return galleryItemViewController;
}

-(void)showPageWithIndex:(NSInteger)index
{
    UIViewController *newViewController=[self viewControllerAtIndex:index];
    
    [self.userInterface showItemViewController:newViewController
                                     direction:index>currentPageIndex?UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse
                                      animated:YES];
    
    currentPageIndex=index;
}

-(void)updateCurrentPageForPageViewController:(UIPageViewController *)pageViewController
{
    UIViewController *viewController=[pageViewController.viewControllers objectAtIndex:0];
    NSUInteger index=[((STGalleryItemViewController *)viewController) getItemIndex];
    
    [self.userInterface setCurrentPageIndex:index];
    
    currentPageIndex=index;
}

-(STGalleryItemViewController *)itemViewControllerForItem:(id<STGalleryItemProtocol>)item withIndex:(NSInteger)index
{
    // Gallery Item Interface Level
    UIStoryboard *storyboard=[self galleryStoryboard];
    STGalleryItemPresenter *galleryItemPresenter=[[STGalleryItemPresenter alloc] init];
    STGalleryItemInteractor *galleryItemInteractor=[[STGalleryItemInteractor alloc] initWithItem:item itemIndex:index];
    STGalleryItemViewController *galleryItemViewController=[storyboard instantiateViewControllerWithIdentifier:STGalleryItemControllerIdentifier];
    
    galleryItemInteractor.output=galleryItemPresenter;
    
    galleryItemPresenter.interactor=galleryItemInteractor;
    galleryItemPresenter.delegate=self;
    
    galleryItemViewController.eventHandler=galleryItemPresenter;
    
    galleryItemPresenter.userInterface=galleryItemViewController;
    
    return galleryItemViewController;
}

-(void)clean
{
    UIPageViewController *pageViewController=[self.userInterface getPageViewController];
    NSArray *views=pageViewController.view.subviews;
    
    if((views.count>0)&&(([[views objectAtIndex:0] isKindOfClass:[UIScrollView class]])))
    {
        UIScrollView *scrollView=[views objectAtIndex:0];
        
        [scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
    currentPageIndex=0;
}

#pragma mark - STGalleryModuleInterface methods
-(void)viewDidLoad
{
    UIPageViewController *pageViewController=[self pageViewController];
    
    pageViewController.dataSource=self;
    pageViewController.delegate=self;
    
    for(UIView *view in pageViewController.view.subviews)
    {
        if([view isKindOfClass:[UIScrollView class]])
        {
            UIScrollView *scrollView=(UIScrollView *)view;
            
            scrollView.delegate=self;
            
            if((self.items)&&(self.items.count==1))
            {
                scrollView.scrollEnabled=NO;
            }
        }
    }
    
    [self.userInterface addPageViewController:pageViewController];
    
    if(self.items)
    {
        currentPageIndex=[self.interactor getInitialItemIndex];
        
        [self.userInterface showItemViewController:[self viewControllerAtIndex:currentPageIndex]
                                         direction:UIPageViewControllerNavigationDirectionForward
                                          animated:NO];
        [self.userInterface setTotalPagesCount:self.items.count withCurrentPageIndex:currentPageIndex];
    }
    
    NSArray *views=pageViewController.view.subviews;
    
    if((views.count>0)&&(([[views objectAtIndex:0] isKindOfClass:[UIScrollView class]])))
    {
        UIScrollView *scrollView=[views objectAtIndex:0];
        
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    }
}

-(void)mustCloseGallery
{
    [self.wireframe hideGallery:YES];
}

-(void)pageHasBeenChanged:(NSInteger)newPageIndex
{
    if(newPageIndex==currentPageIndex)
    {
        return;
    }
    
    autoSlidesCount++;
    
    [self showPageWithIndex:newPageIndex];
}

#pragma mark - STGalleryInteractorOutput methods


#pragma mark - UIPageViewControllerDataSource methods
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index=[((STGalleryItemViewController *)viewController) getItemIndex];
    
    if((index==0)||(index==NSNotFound))
    {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index=[((STGalleryItemViewController *)viewController) getItemIndex];
    
    if(index==NSNotFound)
    {
        return nil;
    }
    
    index++;
    
    if(index==items.count)
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate methods
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if(completed)
    {
        [self updateCurrentPageForPageViewController:pageViewController];
    }
}

#pragma mark - UIScrollViewDelegate methods
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    UIPageViewController *pageViewController=(UIPageViewController *)[self.userInterface getPageViewController];
    
    [self updateCurrentPageForPageViewController:pageViewController];
    
    autoSlidesCount--;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIPageViewController *pageViewController=(UIPageViewController *)[self.userInterface getPageViewController];
    
    [self updateCurrentPageForPageViewController:pageViewController];
}

#pragma mark - NSNotification Observer methods
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([object isKindOfClass:[UIScrollView class]])
    {
        if(autoSlidesCount!=0)
        {
            return;
        }
        
        UIScrollView *scrollView=(UIScrollView *)object;
        NSValue *offsetValue=[change objectForKey:@"new"];
        CGPoint newOffset=[offsetValue CGPointValue];
        
        float progress=(newOffset.x-scrollView.frame.size.width)/scrollView.frame.size.width;
        
        if(progress>0)
        {
            if(progress<0.5f)
            {
                [self.userInterface setCurrentPageIndex:currentPageIndex];
            }
            else
            {
                [self.userInterface setCurrentPageIndex:currentPageIndex+1];
            }
        }
        else
        {
            progress=fabs(progress);
            
            if(progress<0.5f)
            {
                [self.userInterface setCurrentPageIndex:currentPageIndex];
            }
            else
            {
                [self.userInterface setCurrentPageIndex:currentPageIndex-1];
            }
        }
    }
}

#pragma mark - STGalleryItemPresenterDelegate methods
-(void)userTappedOnItemBackground
{
    [self.wireframe hideGallery:YES];
}

@end
