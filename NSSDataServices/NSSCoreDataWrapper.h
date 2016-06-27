//
//  Created by Nikolay Spassov on 28/04/2015.
//
//

#import <Foundation/Foundation.h>
#import "CoreDataExtensions.h"

@interface NSSCoreDataWrapper : NSObject

+ (instancetype)sharedInstance;

@property (strong, nonatomic, readonly) NSManagedObjectContext* mainContext;

@property (copy, nonatomic) NSString* modelName;
@property (copy, nonatomic) NSString* storeType;

- (BOOL)reset;

@end
