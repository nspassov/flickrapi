// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FlickrItem.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

#import "NSSCachedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlickrItemID : NSManagedObjectID {}
@end

@interface _FlickrItem : NSSCachedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FlickrItemID *objectID;

@property (nonatomic, strong, nullable) NSString* blurb;

@property (nonatomic, strong, nullable) NSDate* dateUploaded;

@property (nonatomic, strong, nullable) NSString* ownerId;

@property (nonatomic, strong, nullable) NSString* ownerName;

@property (nonatomic, strong, nullable) NSString* tags;

@property (nonatomic, strong, nullable) NSString* title;

@property (nonatomic, strong, nullable) NSString* uid;

@property (nonatomic, strong, nullable) NSString* url;

@end

@interface _FlickrItem (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBlurb;
- (void)setPrimitiveBlurb:(NSString*)value;

- (NSDate*)primitiveDateUploaded;
- (void)setPrimitiveDateUploaded:(NSDate*)value;

- (NSString*)primitiveOwnerId;
- (void)setPrimitiveOwnerId:(NSString*)value;

- (NSString*)primitiveOwnerName;
- (void)setPrimitiveOwnerName:(NSString*)value;

- (NSString*)primitiveTags;
- (void)setPrimitiveTags:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSString*)primitiveUid;
- (void)setPrimitiveUid:(NSString*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

@end

@interface FlickrItemAttributes: NSObject 
+ (NSString *)blurb;
+ (NSString *)dateUploaded;
+ (NSString *)ownerId;
+ (NSString *)ownerName;
+ (NSString *)tags;
+ (NSString *)title;
+ (NSString *)uid;
+ (NSString *)url;
@end

NS_ASSUME_NONNULL_END
