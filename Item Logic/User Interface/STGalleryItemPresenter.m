//
//  STGalleryItemPresenter.m
//  Sales Tool
//

#import "STGalleryItemPresenter.h"
#import "STGalleryItemInteractor.h"

@interface STGalleryItemPresenter()
{
    
}

@end

@implementation STGalleryItemPresenter

#pragma mark - Init & Dealloc methods
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

#pragma mark - Private methods

#pragma mark - STMainTutorialModuleInterface methods
-(void)viewDidLoad
{
    if([self.interactor isGalleryItemImageLoaded])
    {
        [self.userInterface showImage:[self.interactor getGalleryItemImage]];
    }
    else
    {
        [self.userInterface showPreloader];
        [self.interactor loadGalleryItemImage];
    }
}

-(NSInteger)getCurrentItemIndex
{
    return [self.interactor getCurrentGalleryItemIndex];
}

-(void)userTappedOnBackground
{
    [self.delegate userTappedOnItemBackground];
}

#pragma mark - STGalleryItemInteractorOutput methods
-(void)galleryItemImageLoaded:(UIImage *)image
{
    [self.userInterface showImage:image];
    [self.userInterface hidePreloader];
}

-(void)galleryItemImageLoadingFailed
{
    
}

@end
