// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FlickrItem.m instead.

#import "_FlickrItem.h"

@implementation FlickrItemID
@end

@implementation _FlickrItem

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FlickrItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FlickrItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FlickrItem" inManagedObjectContext:moc_];
}

- (FlickrItemID*)objectID {
	return (FlickrItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic blurb;

@dynamic dateUploaded;

@dynamic ownerId;

@dynamic ownerName;

@dynamic tags;

@dynamic title;

@dynamic uid;

@dynamic url;

@end

@implementation FlickrItemAttributes 
+ (NSString *)blurb {
	return @"blurb";
}
+ (NSString *)dateUploaded {
	return @"dateUploaded";
}
+ (NSString *)ownerId {
	return @"ownerId";
}
+ (NSString *)ownerName {
	return @"ownerName";
}
+ (NSString *)tags {
	return @"tags";
}
+ (NSString *)title {
	return @"title";
}
+ (NSString *)uid {
	return @"uid";
}
+ (NSString *)url {
	return @"url";
}
@end

