//
//  STGalleryInteractor.h
//  Sales Tool
//

#import <Foundation/Foundation.h>
#import "STGalleryInteractorIO.h"

@interface STGalleryInteractor:NSObject<STGalleryInteractorInput>
{
    
}

// items is an array of objects, confirmed to protocol <>
-(id)initWithItems:(NSArray *)items withInitialItemIndex:(NSInteger)initialItemIndex;

@property (nonatomic,weak) id<STGalleryInteractorOutput> output;

@end
