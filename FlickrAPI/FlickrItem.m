#import <UIKit/UIKit.h>
#import "FlickrItem.h"
#import "FlickrKit.h"
#import "NYSFormatters.h"
#import "CoreDataExtensions.h"

@interface FlickrItem ()

// Private interface goes here.

@end

@implementation FlickrItem

+ (void)fetchLatest
{
    FlickrKit* fk = [FlickrKit sharedFlickrKit];
    [fk initializeWithAPIKey:@"06d91ffb9d1de510a0ff515204cf2550" sharedSecret:@"ae6f2d1322bcb0aa"];
    FKFlickrPhotosGetRecent* latest = [[FKFlickrPhotosGetRecent alloc] init];
    latest.extras = @"owner_name,description,tags,date_upload";
    [fk call:latest completion:^(NSDictionary *response, NSError *error) {
        if (response) {
            NSArray* photos = [response valueForKeyPath:@"photos.photo"];
            
            if([photos isKindOfClass:NSArray.class]) {
                
                __block NSManagedObjectContext* tempMOC = [[NSManagedObjectContext mainContext] createChildContext];
                __block NSArray* responseRecords = photos;
                
                [tempMOC performBlock:^{
                    
                    [FlickrItem mergeRecords:responseRecords forEntityClass:FlickrItem.class inManagedObjectContext:tempMOC];
                    
                    if([tempMOC hasChanges]) {
                        [tempMOC save];
                        
                        if([tempMOC.parentContext hasChanges]) {
                            __block NSManagedObjectContext* mainMOC = tempMOC.parentContext;
                            [mainMOC performBlock:^{
                                [mainMOC save];
                            }];
                        }
                    }
                }];
            }
        }
    }];
}

+ (void)mergeRecords:(NSArray *)responseRecords forEntityClass:(Class)entityClass inManagedObjectContext:(NSManagedObjectContext *)tempMOC
{
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(entityClass)];
    NSArray* cacheObjects = [tempMOC executeFetchRequest:fetchRequest];
    
    for(NSManagedObject* obj in cacheObjects) {
        [tempMOC deleteObject:obj];
    }
    
    [responseRecords enumerateObjectsUsingBlock:^(NSDictionary* rec, NSUInteger idx, BOOL* stop) {
        @autoreleasepool {
            NSManagedObject* item = [tempMOC insertedObjectForEntityClass:entityClass];
            
            [item.entity.properties enumerateObjectsUsingBlock:^(NSAttributeDescription* property, NSUInteger idx, BOOL *stop) {
                NSString* key = property.userInfo[@"jsonkey"]? property.userInfo[@"jsonkey"] : property.name;
                id recData = [rec valueForKeyPath:key];
                
                if(recData) {
                    if([property isKindOfClass:[NSRelationshipDescription class]]) {
                        NSRelationshipDescription* rd = item.entity.relationshipsByName[property.name];
                        
                        // if entity has a to-one relationship with another, find the object to establish the relationship with
                        if(![rd isToMany] && [recData isKindOfClass:[NSString class]] && ![recData isEqualToString:@""]) {
                            NSFetchRequest* f = [NSFetchRequest fetchRequestWithEntityName:[[rd destinationEntity] managedObjectClassName]];
                            NSString* s = (NSString *)recData;
                            NSPredicate* p = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"uid = '%@'", s]];
                            [f setPredicate:p];
                            NSArray* parents = [tempMOC executeFetchRequest:f];
                            if([parents firstObject] && [[[parents firstObject] valueForKey:@"uid"] isEqualToString:s]) {
                                [item setValue:[parents firstObject] forKey:rd.name];
                            }
                        }
                        else if([rd isToMany] && ![[rd inverseRelationship] isToMany] && [recData isKindOfClass:[NSArray class]] && [(NSArray *)recData count]) {
                            Class relationshipClass = NSClassFromString([[rd destinationEntity] managedObjectClassName]);
                            [self mergeRecords:recData forEntityClass:relationshipClass inManagedObjectContext:tempMOC];
                        }
                    }
                    else {
                        if(![recData isEqual:[NSNull null]]) {
                            if(property.attributeType == NSStringAttributeType && ![recData isKindOfClass:[NSString class]]) {
                                recData = [recData stringValue];
                            }
                            id transformedValue = [(NSSCachedObject *)item transformValue:recData forKey:key inDictionary:rec];
                            
                            [item setValue:transformedValue forKey:property.name];
                        }
                    }
                }
            }];
            
        }
    }];
}


#pragma mark -

- (id)transformValue:(id)initialValue forKey:(NSString *)key inDictionary:(NSDictionary *)dictionary
{
    if([key isEqualToString:@"dateupload"]) {
        return [NSDate dateWithTimeIntervalSince1970:[(NSString *)initialValue doubleValue]];
    }
    if([key isEqualToString:@"secret"]) {
        return [[[FlickrKit sharedFlickrKit] photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:dictionary] absoluteString];
    }
    return initialValue;
}

@end
