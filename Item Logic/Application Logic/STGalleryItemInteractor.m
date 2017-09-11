//
//  STGalleryItemInteractor.m
//  Sales Tool
//

#import "STGalleryItemInteractor.h"

@interface STGalleryItemInteractor()
{
    
}

@property (nonatomic,retain) id<STGalleryItemProtocol> galleryItem;
@property (nonatomic,assign) NSInteger itemIndex;

@end

@implementation STGalleryItemInteractor

#pragma mark - Init & Dealloc methods
-(id)initWithItem:(id<STGalleryItemProtocol>)item itemIndex:(NSInteger)index
{
    self=[super init];
    
    if(self)
    {
        self.galleryItem=item;
        self.itemIndex=index;
    }
    
    return self;
}

-(void)dealloc
{
    //NSLog(@"%@ dealloced",self);
}

#pragma mark - STGalleryItemInteractorInput methods
-(NSInteger)getCurrentGalleryItemIndex
{
    return self.itemIndex;
}

-(BOOL)isGalleryItemImageLoaded
{
    return [self.galleryItem isImageLoaded];
}

-(UIImage *)getGalleryItemImage
{
    return [self.galleryItem getImage];
}

-(void)loadGalleryItemImage
{
    [self.galleryItem loadImageForDelegate:self andSelector:@selector(imageDownloaded:)];
}

#pragma mark - Private methods
-(void)imageDownloaded:(UIImage *)image
{
    if(self.output)
    {
        if(image)
        {
            [self.output galleryItemImageLoaded:image];
        }
        else
        {
            [self.output galleryItemImageLoadingFailed];
        }
    }
}

@end
