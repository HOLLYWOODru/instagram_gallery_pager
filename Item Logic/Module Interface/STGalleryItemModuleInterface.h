//
//  STGalleryItemModuleInterface.h
//  Sales Tool
//

#ifndef STGalleryItemModuleInterface_h
#define STGalleryItemModuleInterface_h

@protocol STGalleryItemModuleInterface<NSObject>

-(void)viewDidLoad;
-(NSInteger)getCurrentItemIndex;
-(void)userTappedOnBackground;

@end

#endif /* STGalleryItemModuleInterface_h */
