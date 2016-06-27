#import "_FlickrItem.h"

@interface FlickrItem : _FlickrItem

+ (void)fetchLatest;

+ (void)mergeRecords:(NSArray *)responseRecords forEntityClass:(Class)entityClass inManagedObjectContext:(NSManagedObjectContext *)tempMOC;

@end
