//
//  Created by Nikolay Spassov on 03.05.15.
//
//

#import <CoreData/CoreData.h>

@interface NSSCachedObject : NSManagedObject
+ (instancetype)createInsertedObject;


- (id)transformValue:(id)initialValue forKey:(NSString *)key inDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)serializedObject;

- (id)serializeValue:(id)value forJSONkey:(NSString *)keyPath;

@end
