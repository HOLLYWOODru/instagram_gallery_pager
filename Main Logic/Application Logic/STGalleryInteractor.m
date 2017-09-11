//
//  STGalleryInteractor.m
//  Sales Tool
//

#import "STGalleryInteractor.h"

@interface STGalleryInteractor()
{
    
}

@property (nonatomic,retain) NSArray *galleryItems;
@property (nonatomic,assign) NSInteger initialGalleryIndex;

@end

@implementation STGalleryInteractor

#pragma mark - Init method
-(id)initWithItems:(NSArray *)items withInitialItemIndex:(NSInteger)initialItemIndex
{
    self=[super init];
    
    if(self)
    {
        self.galleryItems=[NSArray arrayWithArray:items];
        
        if(initialItemIndex<self.galleryItems.count)
        {
            self.initialGalleryIndex=initialItemIndex;
        }
        else
        {
            self.initialGalleryIndex=0;
        }
    }
    
    return self;
}

-(void)dealloc
{
    //NSLog(@"%@ dealloced",self);
}

#pragma mark - STGalleryInteractorInput methods
-(NSArray *)getItems
{
    return self.galleryItems;
}

-(NSInteger)getInitialItemIndex
{
    return self.initialGalleryIndex;
}

@end
