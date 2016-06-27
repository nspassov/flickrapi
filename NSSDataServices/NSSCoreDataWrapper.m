//
//  Created by Nikolay Spassov on 28/04/2015.
//
//

#import "NSSCoreDataWrapper.h"

@interface NSSCoreDataWrapper ()

@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectContext* persistedContext;
@property (strong, nonatomic) NSManagedObjectContext* mainContext;

@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic) NSURL* managedObjectModelURL;
@property (strong, nonatomic) NSURL* persistentStoreURL;

@end

@implementation NSSCoreDataWrapper

+ (instancetype)sharedInstance
{
    static NSSCoreDataWrapper* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NSSCoreDataWrapper new];
    });
    return instance;
}

- (instancetype)init
{
    return [self initWithModelName:@"FlickrAPI" storeType:NSSQLiteStoreType];
}

- (instancetype)initWithModelName:(NSString *)modelName storeType:(NSString *)storeType
{
    if(self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:nil];
        
        [self setModelName:modelName];
        [self setStoreType:storeType];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:nil];
}

- (void)managedObjectContextDidSave:(NSNotification *)notification
{
    NSManagedObjectContext* savedContext = [notification object];

    if(!savedContext.parentContext)
        return;
    
    if(![savedContext.persistentStoreCoordinator isEqual:self.persistentStoreCoordinator])
        return;
    
    if([savedContext isEqual:self.mainContext]) {
        [savedContext.parentContext performBlock:^{
            [savedContext.parentContext mergeChangesFromContextDidSaveNotification:notification];

            [savedContext.parentContext save];
        }];
    }
}

- (NSManagedObjectContext *)mainContext
{
    if(!_mainContext) {
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_mainContext setParentContext:self.persistedContext];
    }
    return _mainContext;
}

- (NSManagedObjectContext *)persistedContext
{
    if(!_persistedContext) {
        _persistedContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_persistedContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    }
    return _persistedContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];

        NSString* storeType = [self storeType];
        NSURL* storeURL = [self persistentStoreURL];
        NSDictionary* options = @{ NSMigratePersistentStoresAutomaticallyOption: @YES,
                                   NSInferMappingModelAutomaticallyOption: @YES,
                                   NSPersistentStoreFileProtectionKey: NSFileProtectionComplete };
        NSError* error = nil;
        if(![_persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:options error:&error]) {
#ifdef DEBUG
            NSLog(@"%@", error);
#endif
        }
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if(!_managedObjectModel) {
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[self managedObjectModelURL]];
    }
    return _managedObjectModel;
}

- (NSURL *)managedObjectModelURL
{
    if(!_managedObjectModelURL) {
        _managedObjectModelURL = [[NSBundle mainBundle] URLForResource:[self modelName] withExtension:@"momd"];
    }
    return _managedObjectModelURL;
}

- (NSURL *)persistentStoreURL
{
    if(!_persistentStoreURL) {
        if([[self storeType] isEqualToString:NSSQLiteStoreType]) {
            _persistentStoreURL = [[[self applicationDocumentsDirectory] URLByAppendingPathComponent:[self modelName]] URLByAppendingPathExtension:@"sqlite"];
        }
        else if([[self storeType] isEqualToString:NSInMemoryStoreType]) {
            _persistentStoreURL = nil;
        }
    }
    return _persistentStoreURL;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (BOOL)reset
{
    __block BOOL result = YES;
    
    [[self mainContext] performBlockAndWait:^{
        [[self mainContext] reset];
        _mainContext = nil;

        [[self persistedContext] reset];
        _persistedContext = nil;

        NSArray* stores = [[self persistentStoreCoordinator] persistentStores];
        
        for(NSPersistentStore* store in stores) {
            NSError* error;
            
            if(![[self persistentStoreCoordinator] removePersistentStore:store error:&error]) {
#ifdef DEBUG
                NSLog(@"Error removing persistent store: %@", [error localizedDescription]);
#endif
                result = NO;
            }
            else if(![[NSFileManager defaultManager] removeItemAtPath:store.URL.path error:&error]) {
#ifdef DEBUG
                NSLog(@"Error removing file of persistent store: %@", [error localizedDescription]);
#endif
                result = NO;
            }
        }
        
        _persistentStoreCoordinator = nil;
    }];

    return result;
}

@end
