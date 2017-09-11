//
//  STGalleryItemInteractor.h
//  Sales Tool
//

#import <Foundation/Foundation.h>
#import "STGalleryItemInteractorIO.h"

@interface STGalleryItemInteractor:NSObject<STGalleryItemInteractorInput>
{
    
}

-(id)initWithItem:(id<STGalleryItemProtocol>)item itemIndex:(NSInteger)index;

@property (nonatomic,weak) id<STGalleryItemInteractorOutput> output;

@end
