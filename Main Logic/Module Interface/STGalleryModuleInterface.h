//
//  STGalleryModuleInterface.h
//  Sales Tool
//

#ifndef STGalleryModuleInterface_h
#define STGalleryModuleInterface_h

@protocol STGalleryModuleInterface<NSObject>

-(void)viewDidLoad;
-(void)mustCloseGallery;
-(void)pageHasBeenChanged:(NSInteger)newPageIndex;

@end

#endif /* STGalleryModuleInterface_h */
