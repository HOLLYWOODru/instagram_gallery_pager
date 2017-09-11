//
//  STGalleryViewInterface.h
//  Sales Tool
//

#ifndef STGalleryViewInterface_h
#define STGalleryViewInterface_h

@protocol STGalleryViewInterface<NSObject>

-(void)addPageViewController:(UIPageViewController *)_pageViewController;
-(void)showItemViewController:(UIViewController *)itemViewController direction:(UIPageViewControllerNavigationDirection)direction animated:(BOOL)animated;
-(void)setTotalPagesCount:(NSInteger)totalPagesCount withCurrentPageIndex:(NSInteger)index;
-(void)setCurrentPageIndex:(NSInteger)index;
-(UIPageViewController *)getPageViewController;

@end

#endif /* STGalleryViewInterface_h */
