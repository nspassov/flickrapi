//
//  Created by Nikolay Spassov on 03.05.15.
//
//

#import "NSSCachedObject.h"
#import "NSSCoreDataWrapper.h"

@implementation NSSCachedObject

+ (instancetype)createInsertedObject
{
    return [[NSManagedObjectContext mainContext] insertedObjectForEntityClass:self];
}


/**
 Implement in subclasses to transform the value coming from the JSON response into the type used by the local data model.
 */
- (id)transformValue:(id)initialValue forKey:(NSString *)key inDictionary:(NSDictionary *)dictionary
{
    return initialValue;
}

- (id)serializeValue:(id)value forJSONkey:(NSString *)keyPath
{
    return value;
}

- (NSDictionary *)serializedObject
{
    NSMutableDictionary* d = [NSMutableDictionary dictionary];
    [self.entity.properties enumerateObjectsUsingBlock:^(NSAttributeDescription* property, NSUInteger idx, BOOL *stop) {
        NSString* key = property.userInfo[@"jsonkey"]? property.userInfo[@"jsonkey"] : property.name;
        id value = [self valueForKey:property.name];
        if(value) {
            [d setObject:[self serializeValue:value forJSONkey:key] forKey:key];
        }
    }];
    return d;
}

@end
