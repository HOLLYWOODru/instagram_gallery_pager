//
//  STGalleryInteractorIO.h
//  Sales Tool
//

#ifndef STGalleryInteractorIO_h
#define STGalleryInteractorIO_h

#import "PLProtocol.h"

@protocol STGalleryInteractorInput <NSObject>

-(NSArray *)getItems;
-(NSInteger)getInitialItemIndex;

@end


@protocol STGalleryInteractorOutput <NSObject>

@end

#endif /* STGalleryInteractorIO_h */
