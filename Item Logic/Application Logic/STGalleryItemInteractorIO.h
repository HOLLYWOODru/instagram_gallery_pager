//
//  STGalleryItemInteractorIO.h
//  Sales Tool
//

#ifndef STGalleryItemInteractorIO_h
#define STGalleryItemInteractorIO_h

@protocol STGalleryItemInteractorInput <NSObject>

-(NSInteger)getCurrentGalleryItemIndex;
-(BOOL)isGalleryItemImageLoaded;
-(UIImage *)getGalleryItemImage;
-(void)loadGalleryItemImage;

@end


@protocol STGalleryItemInteractorOutput <NSObject>

-(void)galleryItemImageLoaded:(UIImage *)image;
-(void)galleryItemImageLoadingFailed;


@end


@protocol STGalleryItemProtocol<NSObject>

-(BOOL)isImageLoaded;
-(UIImage *)getImage;
-(void)loadImageForDelegate:(id)delegate andSelector:(SEL)selector;

@end

#endif /* STGalleryItemInteractorIO_h */
