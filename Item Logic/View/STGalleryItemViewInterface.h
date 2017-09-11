//
//  STGalleryItemViewInterface.h
//  Sales Tool
//

#ifndef STGalleryItemViewInterface_h
#define STGalleryItemViewInterface_h

@protocol STGalleryItemViewInterface<NSObject>

-(NSInteger)getItemIndex;
-(void)showPreloader;
-(void)hidePreloader;
-(void)showImage:(UIImage *)image;

@end

#endif /* STGalleryItemViewInterface_h */
